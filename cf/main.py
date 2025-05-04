from flask import Flask, request #, render_template
from google.cloud import pubsub_v1
from google.oauth2 import service_account
from googleapiclient import discovery
import google.auth
import re

app = Flask(__name__)

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path("abel-ghack-infra", "ghack-team-create-topic")

def extract_project_id(service_account_email):
    parts = service_account_email.split('@')
    if len(parts) == 2:
        project_id = parts[1].split('.')[0]
        return project_id
    else:
        return None

def verify_service_account(project_id, service_account_email):
    credentials, _ = google.auth.default()
    iam_service = discovery.build('iam', 'v1', credentials=credentials)
    try:
        iam_service.projects().serviceAccounts().get(
            name=f"projects/{project_id}/serviceAccounts/{service_account_email}"
        ).execute()
        return True
    except Exception as e:
        print(f"Error verifying service account: {e}")
        return False

@app.route('/', methods=['GET', 'POST'])
def team_init(request):
    if request.method == 'POST':
        service_account = request.form.get('service_account')
        project_id = extract_project_id(service_account)
        message_data = f'{service_account}'
        message_bytes = message_data.encode('utf-8')
        publisher.publish(topic_path, data=message_bytes)
        return 'Message published to Pub/Sub.'
    else:
        return '''
        <h1>Submit Service Account</h1>
        <form method="post">
            <label for="service_account">Service Account:</label><br>
            <input type="text" id="service_account" name="service_account"><br><br>
            <input type="submit" value="Submit">
        </form>
        '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
