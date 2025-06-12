const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");

const userPreferenceTypeDefs = `
  type UserPreference {
    id: ID!
    user_id: ID!
    type_of_relationship: String
    interested_gender: String
    interested_religion: String
    interested_age_min: Int
    interested_age_max: Int
    max_distance: Int
  }

  type Query {
    getUserPreference(id: ID!): UserPreference
    getUserPreferencesByUserId(user_id: ID!): [UserPreference]
    getAllUserPreferences: [UserPreference]
  }

  input CreateUserPreferenceInput {
  
    user_id: ID!
    type_of_relationship: String
    interested_gender: String
    interested_religion: String
    interested_age_min: Int
    interested_age_max: Int
    max_distance: Int
  }

  input UpdateUserPreferenceInput {
    type_of_relationship: String
    interested_gender: String
    interested_religion: String
    interested_age_min: Int
    interested_age_max: Int
    max_distance: Int
  }

  type Mutation {
    createUserPreference(input: CreateUserPreferenceInput!): UserPreference
    updateUserPreference(id: ID!, input: UpdateUserPreferenceInput!): UserPreference
    deleteUserPreference(id: ID!): Boolean
  }
`;

const userPreferenceResolvers = {
  Query: {
    getUserPreference: async (_, { id }) => {
      const { rows } = await pool.query(
        "SELECT * FROM user_preferences WHERE id = $1",
        [id]
      );
      return rows[0];
    },
    getUserPreferencesByUserId: async (_, { user_id }) => {
      const { rows } = await pool.query(
        "SELECT * FROM user_preferences WHERE user_id = $1",
        [user_id]
      );
      return rows;
    },
    getAllUserPreferences: async () => {
      const { rows } = await pool.query("SELECT * FROM user_preferences");
      return rows;
    },
  },

  Mutation: {
    createUserPreference: async (_, { input }) => {
      const id = uuidv4();
      const {
        user_id,
        type_of_relationship,
        interested_gender,
        interested_religion,
        interested_age_min,
        interested_age_max,
        max_distance,
      } = input;

      const { rows } = await pool.query(
        `INSERT INTO user_preferences (
          id, user_id, type_of_relationship, interested_gender, interested_religion,
          interested_age_min, interested_age_max, max_distance
        ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *`,
        [
          id,
          user_id,
          type_of_relationship,
          interested_gender,
          interested_religion,
          interested_age_min,
          interested_age_max,
          max_distance,
        ]
      );

      return rows[0];
    },

    updateUserPreference: async (_, { id, input }) => {
      const existing = await pool.query(
        "SELECT * FROM user_preferences WHERE id = $1",
        [id]
      );
      if (!existing.rows.length) throw new Error("User preference not found");

      const {
        type_of_relationship,
        interested_gender,
        interested_religion,
        interested_age_min,
        interested_age_max,
        max_distance,
      } = input;

      const { rows } = await pool.query(
        `UPDATE user_preferences SET
          type_of_relationship = COALESCE($2, type_of_relationship),
          interested_gender = COALESCE($3, interested_gender),
          interested_religion = COALESCE($4, interested_religion),
          interested_age_min = COALESCE($5, interested_age_min),
          interested_age_max = COALESCE($6, interested_age_max),
          max_distance = COALESCE($7, max_distance)
         WHERE id = $1
         RETURNING *`,
        [
          id,
          type_of_relationship,
          interested_gender,
          interested_religion,
          interested_age_min,
          interested_age_max,
          max_distance,
        ]
      );

      return rows[0];
    },

    deleteUserPreference: async (_, { id }) => {
      const { rowCount } = await pool.query(
        "DELETE FROM user_preferences WHERE id = $1",
        [id]
      );
      return rowCount > 0;
    },
  },
};

module.exports = {
  userPreferenceTypeDefs,
  userPreferenceResolvers,
};
