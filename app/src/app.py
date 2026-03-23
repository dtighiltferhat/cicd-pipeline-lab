# app/src/app.py
# Simple Flask application used as the CI/CD pipeline target

from flask import Flask, jsonify
import os

app = Flask(__name__)

APP_ENV   = os.getenv("APP_ENV", "local")
LOG_LEVEL = os.getenv("LOG_LEVEL", "info")

@app.route("/")
def index():
    return jsonify({
        "app":     "sample-app",
        "env":     APP_ENV,
        "status":  "running"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/version")
def version():
    build_tag = os.getenv("BUILD_TAG", "local")
    return jsonify({"version": build_tag}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=(APP_ENV != "prod"))
