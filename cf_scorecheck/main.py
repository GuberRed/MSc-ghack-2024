import base64
import jwt
import google
from googleapiclient.discovery import build
from google.oauth2.service_account import Credentials
from google.cloud.container_v1 import ClusterManagerClient
from google.cloud import secretmanager
from kubernetes import client

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.ApplicationDefault()
firebase_admin.initialize_app(cred, {
    'projectId': 'ghack-test-platform'
})
db = firestore.client()


def auth_jwt(request):
    id_token = None
    decoded_id_token = None
    print("auth_jwt")
    auth_header = request.headers.get('Authorization-User') or request.headers.get(
        'Authorization') or request.headers.get('X-Forwarded-Authorization')
    if not auth_header:
        return False, 'No credentials sent. Authorization header with JWT missing!'

    if auth_header.startswith('Bearer '):
        id_token = auth_header.split('Bearer ')[1]
    if auth_header.startswith('bearer '):
        id_token = auth_header.split('bearer ')[1]

    try:
        if 'X-Forwarded-Authorization' in request.headers:
            # Verify Firebase ID token
            decoded_id_token = auth.verify_id_token(id_token)
        elif 'Authorization-User' in request.headers:
            decoded_id_token = jwt.decode(id_token, options={"verify_signature": False})
        else:
            # Decode JWT
            decoded_id_token = jwt.decode(id_token, options={"verify_signature": False})

        request.decoded_token = decoded_id_token
        request.id_token = id_token

        # Extract partner_id claim
        user_email = decoded_id_token.get('email')
        if user_email:
            print(f'User email: {user_email}')
            return True, user_email
        else:
            return False, 'Email not found in JWT token'

    except Exception as e:
        print('Error while processing Authorization header:', e)
        return False, 'Unable to authenticate'


def main(request):
    if request.method == 'OPTIONS':
        # Allows GET requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization, Access-Control-Allow-Origin',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, headers)

    headers = {
        'Access-Control-Allow-Origin': '*'
    }
    points = 0
    project_a_id = "abel-ghack-infra"

    try:
        request_json = request.get_json(silent=True)

        service_account_email = request_json["additional_info"]["service_account"]
        sa_name = service_account_email.split("@")[0]
        project_b_id = service_account_email.split("@")[1][:-len(".iam.gserviceaccount.com")]
        namespace = sa_name + "-" + project_b_id
    except Exception as e:
        errormess = f"Error during parsing ServiceAccount: {e}"
        print(errormess)
        return (errormess, 500, headers)
    # Get credentials for project A service account
    # credentials = os.environ.get("GOOGLE_CREDENTIALS")
    credentials = Credentials.from_service_account_file(
        "/mnt/secrets/abel-ghack-infra.json")

    # Build IAM and Container Engine services
    iam_service = build("iam", "v1", credentials=credentials)

    logged_in, user_email = auth_jwt(request)
    if not logged_in:
        errormess = "Unauthenticated or JWT error"
        print(errormess)
        return (errormess, 401, headers)

    # Check if service account in project B exists
    try:
        iam_service.projects().serviceAccounts().get(
            name=f"projects/{project_b_id}/serviceAccounts/{service_account_email}"
        ).execute()
        print(f"Service account {service_account_email} exists in {project_b_id}")
        points = points + 1
    except Exception as e:
        errormess = f"Error checking SA. Is your naming and IAM correct? Error: {e}"
        print(errormess)
        return (errormess, 500, headers)

        # Check secret value in Secret Manager
    try:
        input_secret = request_json["additional_info"]["secret"]
        # Create Secret Manager client
        secretmanagerclient = secretmanager.SecretManagerServiceClient(credentials=credentials)

        # Get secret version
        name = secretmanagerclient.secret_version_path(project_a_id, namespace, "latest")
        secret_version = secretmanagerclient.access_secret_version(request={"name": name})

        # Compare secret value
        decodedsecret = base64.b64decode(
            secret_version.payload.data.decode("UTF-8")[1:-len(")-imnotpasswordyet:(ps.onemore")])[
                        1:-len(")-nowimpassword:)\n")]
        if str(decodedsecret)[2:-1] != input_secret:
            print(f"Error: Secret {namespace} doesn't match expected value.")
        else:
            print()
            points = points + 3
    except Exception as e:
        print(f"Error accessing secret: {e}")
        #return ('secret error', 500, headers)

    # Get GKE cluster details for the given cluster.
    cluster_manager_client = ClusterManagerClient(credentials=credentials)
    cluster = cluster_manager_client.get_cluster(
        name=f"projects/{project_a_id}/regions/europe-west1/clusters/ghack-cluster")

    # Get a token with the scopes required by GKE
    kubeconfig_creds = credentials.with_scopes(
        ['https://www.googleapis.com/auth/cloud-platform',
         'https://www.googleapis.com/auth/userinfo.email'])
    auth_req = google.auth.transport.requests.Request()
    kubeconfig_creds.refresh(auth_req)

    # Client below is the k8s-client.
    configuration = client.Configuration()

    # the enpoint is an ip address, so we can't use the SSL verification :(
    configuration.host = "https://" + cluster.endpoint + ":443"
    configuration.verify_ssl = False
    kubeconfig_creds.apply(configuration.api_key)
    client.Configuration.set_default(configuration)

    deployment_name = "gubgub-frontend"

    # Check deployment status
    try:
        deployment = client.AppsV1Api().read_namespaced_deployment(name=deployment_name, namespace=namespace)
        # Check for ready replicas, conditions and container image
        ready_replicas = deployment.status.ready_replicas
        conditions = deployment.status.conditions
        container_image = deployment.spec.template.spec.containers[0].image
        # Print deployment information
        print(f"Deployment: {name}")
        print(f"Image: {container_image}")
        if ready_replicas == deployment.spec.replicas:
            print("Status: All replicas ready")
            points = points + 4
        else:
            print(f"Ready replicas: {ready_replicas}/{deployment.spec.replicas}")

        # Check for specific conditions like error states (optional)
        for condition in conditions:
            if condition.type == "Available" and condition.status != "True":
                print(f"Error: Deployment {name} is not available. Reason: {condition.reason}")
            elif condition.type == "Progressing" and condition.status != "True":
                print(f"Warning: Deployment {name} is still progressing. Reason: {condition.reason}")

    except client.exceptions.ApiException as e:
        print(f"Error checking deployment {name}: {e}")

    pod_name = "gubgub-db"
    try:
        pod = client.CoreV1Api().read_namespaced_pod(name=pod_name, namespace=namespace)
        # Check pod status
        if pod.status.phase == "Running" and pod.status.container_statuses[0].ready:
            print(f"Pod: {pod_name} is Up and Ready")
            points = points + 2
        else:
            print(f"Pod: {pod_name} is not Up and Ready. Status: {pod.status.phase}")
    except client.exceptions.ApiException as e:
        print(f"Error checking pod {pod_name}: {e}")

    print(f"Points awarded: {points}")
    firestore_export(points, user_email)
    return (f"Scoring completed! Awarded {points} points.", 200, headers)


def firestore_export(points, user_email):
    collection = 'score2024'
    document = user_email

    score_ref = db.collection(collection).document(document)

    # Set the capital field
    score_ref.update({u'infra': points, u'infra_ts': firestore.SERVER_TIMESTAMP})
