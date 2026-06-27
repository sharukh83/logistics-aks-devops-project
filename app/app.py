from flask import Flask, jsonify, request
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time
import os

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "tracking-service")
APP_VERSION = os.getenv("APP_VERSION", "v1")
ENVIRONMENT = os.getenv("ENVIRONMENT", "dev")

REQUEST_COUNT = Counter(
    "tracking_service_requests_total",
    "Total number of HTTP requests",
    ["method", "endpoint", "http_status"]
)

REQUEST_LATENCY = Histogram(
    "tracking_service_request_latency_seconds",
    "HTTP request latency in seconds",
    ["endpoint"]
)


@app.before_request
def start_timer():
    request.start_time = time.time()


@app.after_request
def record_metrics(response):
    latency = time.time() - request.start_time
    endpoint = request.path

    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=endpoint,
        http_status=response.status_code
    ).inc()

    REQUEST_LATENCY.labels(endpoint=endpoint).observe(latency)

    return response


@app.route("/")
def home():
    return jsonify({
        "message": "Welcome to Logistics Tracking Service",
        "service": APP_NAME,
        "version": APP_VERSION,
        "environment": ENVIRONMENT,
        "status": "running"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": APP_NAME
    }), 200


@app.route("/ready")
def ready():
    return jsonify({
        "status": "ready",
        "service": APP_NAME
    }), 200


@app.route("/tracking/<tracking_id>")
def tracking(tracking_id):
    return jsonify({
        "tracking_id": tracking_id,
        "shipment_status": "In Transit",
        "current_location": "Mumbai Distribution Center",
        "estimated_delivery": "2 days",
        "service": APP_NAME
    })


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
