from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"service": "billing-service", "status": "running"})

@app.route("/metrics")
def metrics():
    return "billing_requests_total 1\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)