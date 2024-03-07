from flask import Flask, request, send_file
from google.cloud import pubsub_v1

app = Flask(__name__)

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path("abel-ghack-infra", "ghack-team-create-topic")

@app.route('/', methods=['POST'])
def handle_request():
    if request.method == 'POST':
        serviceaccount = request.form.get('serviceaccount')
        if serviceaccount:
            message_data = f'Logged in successfully as {serviceaccount}!'
            message_bytes = message_data.encode('utf-8')
            publisher.publish(topic_path, data=message_bytes)
            return 'Message published to Pub/Sub.'
        else:
            return 'Invalid service account.'
    else:
        return send_file('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
