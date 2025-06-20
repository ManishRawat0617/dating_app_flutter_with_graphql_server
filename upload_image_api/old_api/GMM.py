import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
from sklearn.mixture import GaussianMixture
from sklearn.metrics import silhouette_score

# Load dataset
df = pd.read_csv("./synthetic_user_lifestyle_data.csv")
user_ids = df.pop("user_id")

# Detect column types
categorical_cols = df.select_dtypes(include=["object"]).columns.tolist()
boolean_cols = df.select_dtypes(include=["bool"]).columns.tolist()

# Encode categorical features
encoder = OneHotEncoder()
encoded_cats = encoder.fit_transform(df[categorical_cols]).toarray()
encoded_bools = df[boolean_cols].astype(int).values

# Final feature matrix
features = np.hstack([encoded_bools, encoded_cats])

# Choose best number of clusters using silhouette score
best_score = -1
best_k = 2
for k in range(2, 11):  # Try clusters from 2 to 10
    gmm = GaussianMixture(n_components=k, random_state=42)
    labels = gmm.fit_predict(features)
    score = silhouette_score(features, labels)
    if score > best_score:
        best_score = score
        best_k = k

print(f"\nBest number of clusters based on silhouette score: {best_k}")

# Fit GMM with best cluster count
final_gmm = GaussianMixture(n_components=best_k, random_state=42)
final_clusters = final_gmm.fit_predict(features)

# Create DataFrame with cluster assignments
clustered_users = pd.DataFrame({
    "user_id": user_ids,
    "cluster": final_clusters
})

# Save results
output_file = "gmm_clustered_lifestyle_users.csv"
clustered_users.to_csv(output_file, index=False)

# Print cluster distribution
cluster_counts = clustered_users["cluster"].value_counts().sort_index()
print("\nUser count per cluster:")
for cluster_id, count in cluster_counts.items():
    print(f"Cluster {cluster_id}: {count} users")

print(f"\nGMM clustering results saved to {output_file}")

# # Get soft assignments (probabilities)
# probabilities = final_gmm.predict_proba(features)

# # Save soft cluster membership probabilities
# prob_df = pd.DataFrame(probabilities, columns=[f"prob_cluster_{i}" for i in range(best_k)])
# prob_df["user_id"] = user_ids

# # Save to CSV
# prob_df.to_csv("gmm_cluster_probabilities.csv", index=False)
# print(f"\nSoft cluster probabilities saved to gmm_cluster_probabilities.csv")


from sklearn.metrics.pairwise import cosine_similarity

def get_top_matches(user_id_query, top_n=5):
    index = user_ids[user_ids == user_id_query].index[0]
    user_vector = features[index].reshape(1, -1)
    
    # Find users in the same cluster
    user_cluster = final_clusters[index]
    same_cluster_indices = np.where(final_clusters == user_cluster)[0]

    # Compute similarity
    sims = cosine_similarity(user_vector, features[same_cluster_indices])[0]
    
    # Sort by similarity
    top_indices = same_cluster_indices[np.argsort(sims)[::-1]]
    top_user_ids = user_ids.iloc[top_indices[1:top_n+1]].values  # Exclude self

    print(f"\nTop {top_n} matches for user '{user_id_query}' in cluster {user_cluster}:")
    for rank, uid in enumerate(top_user_ids, start=1):
        print(f"{rank}. {uid}")

# Example usage:
get_top_matches("user7", top_n=5)
