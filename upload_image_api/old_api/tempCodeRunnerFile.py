from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
from sklearn.mixture import GaussianMixture
import joblib

app = Flask(__name__)

# === Load model and encoder ===
df = pd.read_csv("synthetic_user_lifestyle_data.csv")
bool_cols = df.select_dtypes(include="bool").columns.tolist()
cat_cols = df.select_dtypes(include="object").drop("user_id", axis=1).columns.tolist()

encoder = OneHotEncoder(handle_unknown='ignore')
X_cat = encoder.fit_transform(df[cat_cols]).toarray()
X_bool = df[bool_cols].astype(int).values
X = np.hstack([X_bool, X_cat])

gmm = GaussianMixture(n_components=10, random_state=42).fit(X)

@app.route("/assign-cluster", methods=["POST"])
def assign_cluster():
    data = request.json
    user_df = pd.DataFrame([data])
    user_cat = encoder.transform(user_df[cat_cols]).toarray()
    user_bool = user_df[bool_cols].astype(int).values
    features = np.hstack([user_bool, user_cat])
    cluster = int(gmm.predict(features)[0])
    return jsonify({"cluster": cluster})

if __name__ == "__main__":
    app.run(port=5001)

