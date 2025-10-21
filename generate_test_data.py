#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Générateur simple de données de test (CSV + JSON)

import csv
import json
import random
import datetime

N = 50  # nombre de lignes à générer
names = ["Alice", "Bob", "Charlie", "David", "Emma", "Fanny", "Gilles", "Hélène", "Ibrahim", "Julia"]
products = ["widget", "gadget", "doohickey", "thingamajig"]

rows = []
for i in range(1, N + 1):
    row = {
        "id": i,
        "name": random.choice(names),
        "product": random.choice(products),
        "quantity": random.randint(1, 20),
        "price": round(random.uniform(5.0, 200.0), 2),
        "timestamp": (datetime.datetime.now() - datetime.timedelta(days=random.randint(0, 365))).isoformat()
    }
    rows.append(row)

# CSV
csv_path = "sample.csv"
with open(csv_path, "w", newline='', encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["id", "name", "product", "quantity", "price", "timestamp"])
    writer.writeheader()
    for r in rows:
        writer.writerow(r)

# JSON
json_path = "sample.json"
with open(json_path, "w", encoding='utf-8') as f:
    json.dump(rows, f, ensure_ascii=False, indent=2)

print(f"✅ Généré {len(rows)} lignes :")
print(" -", csv_path)
print(" -", json_path)
