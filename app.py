import os

from flask import Flask
import math
import random

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "Hello Prediction"

@app.route('/rand')
def rand():
    num = math.floor(random.uniform(0, 100))
    return str(num)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
