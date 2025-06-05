const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const matchTypeDefs = `
type Match {
  id: ID!
  user1_id: ID!
  user2_id: ID!
  matched_at: String
}

type Query {
  getAllMatches: [Match!]
  getMatchById(id: ID!): Match
  getMatchesByUser(user_id: ID!): [Match!]
}

type Mutation {
  addMatch(user1_id: ID!, user2_id: ID!): Match
  deleteMatch(id: ID!): Match
}
`;

const matchResolvers = {
  Query: {
    getAllMatches: async () => {
      const res = await pool.query("SELECT * FROM matches");
      return res.rows;
    },

    getMatchById: async (_, { id }) => {
      const res = await pool.query("SELECT * FROM matches WHERE id = $1", [id]);
      return res.rows[0];
    },

    getMatchesByUser: async (_, { user_id }) => {
      const res = await pool.query(
        `SELECT * FROM matches WHERE user1_id = $1 OR user2_id = $1`,
        [user_id]
      );
      return res.rows;
    },
  },

  Mutation: {
    addMatch: async (_, { user1_id, user2_id }) => {
      const id = uuidv4();
      const res = await pool.query(
        `INSERT INTO matches (id, user1_id, user2_id, matched_at) VALUES ($1, $2, $3, CURRENT_TIMESTAMP) RETURNING *`,
        [id, user1_id, user2_id]
      );
      return res.rows[0];
    },

    deleteMatch: async (_, { id }) => {
      const res = await pool.query(
        "DELETE FROM matches WHERE id = $1 RETURNING *",
        [id]
      );
      return res.rows[0];
    },
  },
};

module.exports = { matchTypeDefs, matchResolvers };
