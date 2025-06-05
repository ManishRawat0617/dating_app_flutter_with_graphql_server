const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const likeTypeDefs = `
type Like {
  id: ID!
  from_user_id: ID!
  to_user_id: ID!
  liked_at: String
}

type Query {
  getLike(id: ID!): Like
  getAllLikes: [Like!]
  getLikesByUser(userId: ID!): [Like!]
}

type Mutation {
  addLike(from_user_id: ID!, to_user_id: ID!): Like
  deleteLike(id: ID!): Like
}
`;

const likeResolvers = {
  Query: {
    getLike: async (_, { id }) => {
      const result = await pool.query("SELECT * FROM likes WHERE id = $1", [
        id,
      ]);
      return result.rows[0];
    },
    getAllLikes: async () => {
      const result = await pool.query("SELECT * FROM likes");
      return result.rows;
    },
    getLikesByUser: async (_, { userId }) => {
      const result = await pool.query(
        "SELECT * FROM likes WHERE from_user_id = $1",
        [userId]
      );
      return result.rows;
    },
  },

  Mutation: {
    addLike: async (_, { from_user_id, to_user_id }) => {
      // Check for duplicate
      const exists = await pool.query(
        "SELECT * FROM likes WHERE from_user_id = $1 AND to_user_id = $2",
        [from_user_id, to_user_id]
      );
      if (exists.rows.length > 0) {
        throw new Error("User already liked this profile");
      }

      const id = uuidv4();
      const result = await pool.query(
        "INSERT INTO likes (id, from_user_id, to_user_id) VALUES ($1, $2, $3) RETURNING *",
        [id, from_user_id, to_user_id]
      );
      return result.rows[0];
    },

    deleteLike: async (_, { id }) => {
      const result = await pool.query(
        "DELETE FROM likes WHERE id = $1 RETURNING *",
        [id]
      );
      if (result.rows.length === 0) {
        throw new Error("Like not found");
      }
      return result.rows[0];
    },
  },
};

module.exports = { likeTypeDefs, likeResolvers };
