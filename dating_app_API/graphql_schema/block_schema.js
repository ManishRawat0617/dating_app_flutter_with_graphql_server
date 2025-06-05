const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");

const blockTypeDefs = `
type Block {
  id: ID!
  blocker_id: ID!
  blocked_id: ID!
  timestamp: String
}

type Query {
  getAllBlocks: [Block!]
  getBlockById(id: ID!): Block
  getBlocksByBlocker(blocker_id: ID!): [Block!]
}

type Mutation {
  addBlock(blocker_id: ID!, blocked_id: ID!): Block
  deleteBlock(id: ID!): Block
  updateBlock(id: ID!, timestamp: String): Block
}
`;

const blockResolvers = {
  Query: {
    getAllBlocks: async () => {
      const res = await pool.query("SELECT * FROM blocks");
      return res.rows;
    },

    getBlockById: async (_, { id }) => {
      const res = await pool.query("SELECT * FROM blocks WHERE id = $1", [id]);
      return res.rows[0];
    },

    getBlocksByBlocker: async (_, { blocker_id }) => {
      const res = await pool.query("SELECT * FROM blocks WHERE blocker_id = $1", [blocker_id]);
      return res.rows;
    },
  },

  Mutation: {
    addBlock: async (_, { blocker_id, blocked_id }) => {
      const id = uuidv4();
      const res = await pool.query(
        `INSERT INTO blocks (id, blocker_id, blocked_id, timestamp) 
         VALUES ($1, $2, $3, CURRENT_TIMESTAMP) RETURNING *`,
        [id, blocker_id, blocked_id]
      );
      return res.rows[0];
    },

    deleteBlock: async (_, { id }) => {
      const res = await pool.query("DELETE FROM blocks WHERE id = $1 RETURNING *", [id]);
      return res.rows[0];
    },

    updateBlock: async (_, { id, timestamp }) => {
      const res = await pool.query(
        `UPDATE blocks SET timestamp = COALESCE($2, timestamp) WHERE id = $1 RETURNING *`,
        [id, timestamp]
      );
      return res.rows[0];
    },
  },
};

module.exports = { blockTypeDefs, blockResolvers };
