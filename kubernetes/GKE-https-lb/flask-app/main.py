from flask import Flask
from os import environ


app = Flask(__name__)

MY_POD_NAME = environ.get('MY_POD_NAME')
MY_NODE_NAME = environ.get('MY_NODE_NAME')
MY_POD_IP = environ.get('MY_POD_IP')

CONTAINER_DETAILS = """
<p>
<b>MY POD NAME:</b> {} <br>
<b>MY NODE NAME:</b> {} <br>
<b>MY POD IP:</b> {} <br>
</p>
""" .format(MY_POD_NAME, MY_NODE_NAME, MY_POD_IP)

@app.route("/")
def hello():
    return "Hello from Python!"

@app.route('/status')
def verify():
    return CONTAINER_DETAILS

if __name__ == "__main__":
    app.run(host='0.0.0.0')