from flask import Flask, request #, render_template
from google.cloud import pubsub_v1
import re

app = Flask(__name__)

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path("abel-ghack-infra", "ghack-team-create-topic")

def is_valid_service_account(service_account):
    pattern = r'^[a-zA-Z0-9-_]+@[a-zA-Z0-9-_]+\.[a-zA-Z0-9-_]+$'
    return bool(re.match(pattern, service_account))

@app.route('/', methods=['GET', 'POST'])
def handle_request(request):  # Add request as an argument
    if request.method == 'POST':
        service_account = request.form.get('service_account')
        if is_valid_service_account(service_account):
            # message_data = f'Logged in successfully as {serviceaccount}!'
            # message_bytes = message_data.encode('utf-8')
            # publisher.publish(topic_path, data=message_bytes)
            return 'Message published to Pub/Sub.'
        else:
            return 'Invalid service account.'
    else:
        #return render_template('index.html')
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
