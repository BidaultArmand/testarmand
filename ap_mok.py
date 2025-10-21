#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# API factice avec Flask pour simuler des endpoints simples

from flask import Flask, jsonify, request
import random

app = Flask(__name__)

@app.route("/ping", methods=["GET"])
def ping():
    return jsonify({"message": "pong", "status": "ok"})

@app.route("/user/<int:user_id>", methods=["GET"])
def get_user(user_id):
    fake_user = {
        "id": user_id,
        "name": random.choice(["Alice", "Bob", "Charlie"]),
        "score": random.randint(0, 100)
    }
    return jsonify(fake_user)

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    if not data or "features" not in data:
        return jsonify({"error": "missing features"}), 400
    prediction = sum(data["features"]) / len(data["features"])
    return jsonify({"prediction": prediction})

if __name__ == "__main__":
    app.run(port=5000, debug=True)
