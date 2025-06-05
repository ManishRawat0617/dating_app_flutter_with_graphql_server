const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const photoTypeDefs = `
type Photo {
  id: ID!
  user_id: ID!
  url: String!
  is_main: Boolean
}

type Query {
  getAllPhotos: [Photo!]
  getPhotosByUserId(user_id: ID!): [Photo!]
}

type Mutation {
  addPhoto(user_id: ID!, url: String!, is_main: Boolean): Photo
  updatePhoto(id: ID!, url: String, is_main: Boolean): Photo
  deletePhoto(id: ID!): Photo
}
`;

const photoResolvers = {
  Query: {
    getAllPhotos: async () => {
      const res = await pool.query("SELECT * FROM photos");
      return res.rows;
    },

    getPhotosByUserId: async (_, { user_id }) => {
      const res = await pool.query("SELECT * FROM photos WHERE user_id = $1", [user_id]);
      return res.rows;
    },
  },

  Mutation: {
    addPhoto: async (_, { user_id, url, is_main }) => {
      const id = uuidv4();
      const res = await pool.query(
        `INSERT INTO photos (id, user_id, url, is_main) VALUES ($1, $2, $3, $4) RETURNING *`,
        [id, user_id, url, is_main]
      );
      return res.rows[0];
    },

    updatePhoto: async (_, { id, url, is_main }) => {
      const res = await pool.query(
        `UPDATE photos SET
          url = COALESCE($2, url),
          is_main = COALESCE($3, is_main)
         WHERE id = $1 RETURNING *`,
        [id, url, is_main]
      );
      return res.rows[0];
    },

    deletePhoto: async (_, { id }) => {
      const res = await pool.query("DELETE FROM photos WHERE id = $1 RETURNING *", [id]);
      return res.rows[0];
    },
  },
};

module.exports = { photoTypeDefs, photoResolvers };
