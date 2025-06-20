import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
from sklearn.mixture import GaussianMixture

# Load and preprocess dataset
df = pd.read_csv("synthetic_user_lifestyle_data.csv")
user_ids = df["user_id"]
boolean_cols = df.select_dtypes(include="bool").columns.tolist()
categorical_cols = df.select_dtypes(include="object").drop("user_id", axis=1).columns.tolist()

# Preprocess features for clustering
encoder = OneHotEncoder()
encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
encoded_bools = df[boolean_cols].astype(int).values
features = np.hstack([encoded_bools, encoded_cats])

# Fit GMM
gmm = GaussianMixture(n_components=10, random_state=42)
clusters = gmm.fit_predict(features)

# Append cluster to original DataFrame
df["cluster"] = clusters

# Compatibility scoring function
def compute_compatibility(user_id_1, user_id_2, w_bool=0.4, w_cat=0.4, w_cluster=0.2):
    u1 = df[df["user_id"] == user_id_1].iloc[0]
    u2 = df[df["user_id"] == user_id_2].iloc[0]

    # Boolean similarity
    bool_matches = sum(u1[col] == u2[col] for col in boolean_cols)
    bool_score = bool_matches / len(boolean_cols)

    # Categorical similarity
    cat_matches = sum(u1[col] == u2[col] for col in categorical_cols)
    cat_score = cat_matches / len(categorical_cols)

    # Cluster match bonus
    same_cluster = int(u1["cluster"] == u2["cluster"])

    # Final weighted score
    final_score = (w_bool * bool_score) + (w_cat * cat_score) + (w_cluster * same_cluster)
    return round(final_score, 3)

# Example: Compare two users
user_a = "user7"
user_b = "user107"
score = compute_compatibility(user_a, user_b)
print(f"Compatibility between {user_a} and {user_b}: {score}")
