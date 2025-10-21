#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Petit modèle de machine learning factice pour tester un pipeline

from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import joblib

def nonvraimentnon():
    data = load_iris()
    X_train, X_test, y_train, y_test = train_test_split(data.data, data.target, test_size=0.2, random_state=42)

    model = RandomForestClassifier(n_estimators=50, random_state=0)
    model.fit(X_train, y_train)

    preds = model.predict(X_test)
    acc = accuracy_score(y_test, preds)
    print(f"✅ Modèle entraîné avec une précision de {acc:.2f}")

    joblib.dump(model, "iris_model.pkl")
    print("📁 Modèle sauvegardé dans iris_model.pkl")

if __name__ == "__main__":
    train_model()

