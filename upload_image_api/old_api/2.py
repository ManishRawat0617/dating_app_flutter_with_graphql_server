# import pandas as pd
# from sklearn.preprocessing import OneHotEncoder
# from sklearn.cluster import KMeans
# import numpy as np

# # Read dataset
# df = pd.read_csv("./synthetic_user_lifestyle_data.csv")
# user_ids = df.pop("user_id")  # Save user_ids separately

# # Identify column types
# categorical_cols = df.select_dtypes(include=["object"]).columns.tolist()
# boolean_cols = df.select_dtypes(include=["bool"]).columns.tolist()

# # One-hot encode categorical columns
# encoder = OneHotEncoder()
# encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
# encoded_bools = df[boolean_cols].astype(int).values

# # Combine features
# features = np.hstack([encoded_bools, encoded_cats])

# # KMeans clustering
# k = 10  # choose number of clusters
# kmeans = KMeans(n_clusters=k, random_state=42)
# clusters = kmeans.fit_predict(features)

# # Combine results into a DataFrame
# clustered_users = pd.DataFrame({
#     "user_id": user_ids,
#     "cluster": clusters
# })

# # Save results to CSV
# output_file = "clustered_lifestyle_clusters.csv"
# clustered_users.to_csv(output_file, index=False)

# # Print cluster distribution
# cluster_counts = clustered_users["cluster"].value_counts().sort_index()
# print("User count per cluster:")
# for cluster_id, count in cluster_counts.items():
#     print(f"Cluster {cluster_id}: {count} users")

# print(f"\nClustering results saved to {output_file}")


import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
from sklearn.mixture import GaussianMixture
import psycopg2  # Or use SQLAlchemy if preferred

# === STEP 1: Load existing user lifestyle data and fit model ===

df = pd.read_csv("synthetic_user_lifestyle_data.csv")

boolean_cols = df.select_dtypes(include="bool").columns.tolist()
categorical_cols = df.select_dtypes(include="object").drop("user_id", axis=1).columns.tolist()

encoder = OneHotEncoder(handle_unknown='ignore')
encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
encoded_bools = df[boolean_cols].astype(int).values
features = np.hstack([encoded_bools, encoded_cats])

gmm = GaussianMixture(n_components=10, random_state=42)
gmm.fit(features)


# === STEP 2: Function to assign cluster to a new user ===

def assign_cluster(new_user_data: dict) -> int:
    # Convert to DataFrame
    user_df = pd.DataFrame([new_user_data])

    # Match columns exactly
    user_cat = encoder.transform(user_df[categorical_cols]).toarray()
    user_bool = user_df[boolean_cols].astype(int).values

    user_features = np.hstack([user_bool, user_cat])
    cluster = gmm.predict(user_features)[0]
    return cluster


# === STEP 3: Save user with assigned cluster to database ===

def save_user_to_db(user_data: dict, cluster: int):
    # Sample using psycopg2 for PostgreSQL
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="dating_app",
            user="postgres",
            password="1331"
        )
        cur = conn.cursor()

        insert_query = """
        INSERT INTO lifestyle (
            user_id, smoking, drinking, pets, wants_kids,
            dietary_preference, relationship_goal, fitness_level,
            religion, sleep_schedule, cluster
        )
        VALUES (%(user_id)s, %(smoking)s, %(drinking)s, %(pets)s, %(wants_kids)s,
                %(dietary_preference)s, %(relationship_goal)s, %(fitness_level)s,
                %(religion)s, %(sleep_schedule)s, %(cluster)s);
        """

        user_data["cluster"] = int(cluster)
        cur.execute(insert_query, user_data)
        conn.commit()

        print(f"User {user_data['user_id']} saved to DB with cluster {cluster}")
        cur.close()
        conn.close()

    except Exception as e:
        print(f"Error saving to DB: {e}")


# === STEP 4: Example usage ===

if __name__ == "__main__":
    new_user = {
        "user_id": "ab75b81b-a237-4253-ae4e-65bb5e0ac7c7",
        "smoking": True,
        "drinking": False,
        "pets": True,
        "wants_kids": True,
        "dietary_preference": "vegan",
        "relationship_goal": "long-term",
        "fitness_level": "moderately active",
        "religion": "hindu",
        "sleep_schedule": "early bird"
    }

    assigned_cluster = assign_cluster(new_user)
    print(f"Assigned cluster: {assigned_cluster}")
    save_user_to_db(new_user, assigned_cluster)
