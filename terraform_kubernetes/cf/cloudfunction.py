from google.auth import impersonated_credentials
from google.auth.transport.requests import Request
from google.cloud import logging
from google.cloud.container_v1 import ClusterManagerClient
import os
import base64

def create_namespace(event, context):
    if 'data' in event:
        data = base64.b64decode(event['data']).decode('utf-8')
        service_account = data.strip()

        gke_cluster = os.environ.get('GKE_CLUSTER')

        # Impersonate the provided service account
        impersonated_creds = impersonated_credentials.Credentials.from_subject(service_account, request=Request())

        # Create a ClusterManagerClient with impersonated credentials
        cluster_manager_client = ClusterManagerClient(credentials=impersonated_creds)

        # Create the namespace
        project_id = 'your-project-id'
        zone = 'your-gke-cluster-zone'
        parent = f"projects/{project_id}/locations/{zone}/clusters/{gke_cluster}"
        namespace_body = {"name": f"namespace-{service_account}"}

        try:
            response = cluster_manager_client.create_namespace(parent=parent, namespace=namespace_body)
            log_success(service_account)
            return 'Namespace created successfully.'
        except Exception as e:
            log_error(service_account, str(e))
            return 'Error creating namespace.'

    return 'No data provided.'

def log_success(service_account):
    logging_client = logging.Client()
    logger = logging_client.logger('create-namespace-function')
    logger.log_text(f'Successfully created namespace for service account: {service_account}')

def log_error(service_account, error_message):
    logging_client = logging.Client()
    logger = logging_client.logger('create-namespace-function')
    logger.log_text(f'Error creating namespace for service account: {service_account}. Error message: {error_message}')
