# import pandas as pd
# from sklearn.preprocessing import OneHotEncoder
# from sklearn.cluster import KMeans
# import numpy as np

# # Sample lifestyle data
# data = [
#     {
#         "user_id": "user0",
#         "drinking": False,
#         "dietary_preference": "vegan",
#         "pets": True,
#         "relationship_goal": "friends with benefits",
#         "fitness_level": "moderately active",
#         "religion": "jewish",
#         "sleep_schedule": "early bird",
#         "smoking": True,
#         "wants_kids": True
#     },
#     {
#         "user_id": "user1",
#         "drinking": True,
#         "dietary_preference": "vegetarian",
#         "pets": False,
#         "relationship_goal": "long-term",
#         "fitness_level": "very active",
#         "religion": "christian",
#         "sleep_schedule": "night owl",
#         "smoking": False,
#         "wants_kids": False
#     },
#     {
#         "user_id": "user2",
#         "drinking": False,
#         "dietary_preference": "non-veg",
#         "pets": True,
#         "relationship_goal": "casual dating",
#         "fitness_level": "active",
#         "religion": "hindu",
#         "sleep_schedule": "early bird",
#         "smoking": True,
#         "wants_kids": True
#     },
#     # Add 7 more similar entries...
# ]

# df = pd.read_csv("./synthetic_user_lifestyle_data.csv")
# user_ids = df.pop("user_id")  # Save user_ids separately

# # One-hot encode categorical columns
# categorical_cols = df.select_dtypes(include=["object"]).columns.tolist()
# boolean_cols = df.select_dtypes(include=["bool"]).columns.tolist()

# encoder = OneHotEncoder()
# encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
# encoded_bools = df[boolean_cols].astype(int).values

# # Combine features
# features = np.hstack([encoded_bools, encoded_cats])

# # KMeans clustering
# k = 3  # choose number of clusters
# kmeans = KMeans(n_clusters=k, random_state=42)
# clusters = kmeans.fit_predict(features)

# # Combine results
# clustered_users = pd.DataFrame({
#     "user_id": user_ids,
#     "cluster": clusters
# })

# print(clustered_users)


import pandas as pd
from sklearn.preprocessing import OneHotEncoder
from sklearn.cluster import KMeans
import numpy as np

# Read dataset
df = pd.read_csv("./synthetic_user_lifestyle_data.csv")
user_ids = df.pop("user_id")  # Save user_ids separately

# Identify column types
categorical_cols = df.select_dtypes(include=["object"]).columns.tolist()
boolean_cols = df.select_dtypes(include=["bool"]).columns.tolist()

# One-hot encode categorical columns
encoder = OneHotEncoder()
encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
encoded_bools = df[boolean_cols].astype(int).values

# Combine features
features = np.hstack([encoded_bools, encoded_cats])

# KMeans clustering
k = 10  # choose number of clusters
kmeans = KMeans(n_clusters=k, random_state=42)
clusters = kmeans.fit_predict(features)

# Combine results into a DataFrame
clustered_users = pd.DataFrame({
    "user_id": user_ids,
    "cluster": clusters
})

# Save results to CSV
output_file = "clustered_lifestyle_clusters.csv"
clustered_users.to_csv(output_file, index=False)

print(f"Clustering results saved to {output_file}")
