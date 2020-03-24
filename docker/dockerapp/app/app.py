from flask import Flask
import math
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'



@app.route('/cpu_load')

def cpu_load():
    result = []
    def cpu_load_gen():
        # for x in range(n):
        #     return (math.sqrt(0.000001))

        while True:
            # for x in range(n):
            result.append(math.sqrt(0.000001))
        return result

    return cpu_load_gen()


if __name__ == '__main__':
    app.run(host='0.0.0.0')
