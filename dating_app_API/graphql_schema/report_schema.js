const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const reportTypeDefs = `
type Report {
  id: ID!
  reporter_id: ID!
  reported_id: ID!
  reason: String!
  timestamp: String
}

type Query {
  getAllReports: [Report!]
  getReportById(id: ID!): Report
  getReportsByReporter(reporter_id: ID!): [Report!]
}

type Mutation {
  addReport(reporter_id: ID!, reported_id: ID!, reason: String!): Report
}
`;

const reportResolvers = {
  Query: {
    getAllReports: async () => {
      const res = await pool.query("SELECT * FROM reports");
      return res.rows;
    },

    getReportById: async (_, { id }) => {
      const res = await pool.query("SELECT * FROM reports WHERE id = $1", [id]);
      return res.rows[0];
    },

    getReportsByReporter: async (_, { reporter_id }) => {
      const res = await pool.query(
        "SELECT * FROM reports WHERE reporter_id = $1",
        [reporter_id]
      );
      return res.rows;
    },
  },

  Mutation: {
    addReport: async (_, { reporter_id, reported_id, reason }) => {
      const id = uuidv4();
      const res = await pool.query(
        `INSERT INTO reports (id, reporter_id, reported_id, reason) 
         VALUES ($1, $2, $3, $4) RETURNING *`,
        [id, reporter_id, reported_id, reason]
      );
      return res.rows[0];
    },
  },
};

module.exports = { reportTypeDefs, reportResolvers };
