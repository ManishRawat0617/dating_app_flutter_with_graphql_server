const { GraphQLError } = require("graphql");
const pool = require("../config/database/postgreSQL");
const jwt = require("jsonwebtoken");

const lifestyleTypeDefs = `
  type Lifestyle {
    user_id: ID!
    smoking: Boolean
    drinking: Boolean
    pets: Boolean
    wants_kids: Boolean
    dietary_preference: String
    relationship_goal: String
    fitness_level: String
    religion: String
    sleep_schedule: String
    created_at: String
  }

  extend type Query {
    getAllLifestyles: [Lifestyle!]
    getLifestyleByUserId(user_id: ID!): Lifestyle
  }

  extend type Mutation {
    addLifestyle(
      user_id: ID!
      smoking: Boolean
      drinking: Boolean
      pets: Boolean
      wants_kids: Boolean
      dietary_preference: String
      relationship_goal: String
      fitness_level: String
      religion: String
      sleep_schedule: String
    ): Lifestyle

    updateLifestyle(
      user_id: ID!
      smoking: Boolean
      drinking: Boolean
      pets: Boolean
      wants_kids: Boolean
      dietary_preference: String
      relationship_goal: String
      fitness_level: String
      religion: String
      sleep_schedule: String
    ): Lifestyle

    deleteLifestyle(user_id: ID!): Lifestyle
  }
`;

const lifestyleResolvers = {
  Query: {
    getAllLifestyles: async () => {
      const { rows } = await pool.query("SELECT * FROM lifestyle");
      return rows;
    },

    getLifestyleByUserId: async (_, { user_id }) => {
      const { rows } = await pool.query(
        "SELECT * FROM lifestyle WHERE user_id = $1",
        [user_id]
      );
      return rows[0] || null;
    },
  },

  Mutation: {
    addLifestyle: async (
      _,
      {
        user_id,
        smoking,
        drinking,
        pets,
        wants_kids,
        dietary_preference,
        relationship_goal,
        fitness_level,
        religion,
        sleep_schedule,
      }
    ) => {
      try {
        const { rows } = await pool.query(
          `INSERT INTO lifestyle (
            user_id, smoking, drinking, pets, wants_kids,
            dietary_preference, relationship_goal, fitness_level,
            religion, sleep_schedule
          )
          VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
          RETURNING *`,
          [
            user_id,
            smoking,
            drinking,
            pets,
            wants_kids,
            dietary_preference?.toLowerCase() || null,
            relationship_goal?.toLowerCase() || null,
            fitness_level?.toLowerCase() || null,
            religion?.toLowerCase() || null,
            sleep_schedule?.toLowerCase() || null,
          ]
        );
        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to add lifestyle", {
          extensions: { code: "DB_ERROR", err },
        });
      }
    },

    updateLifestyle: async (
      _,
      {
        user_id,
        smoking,
        drinking,
        pets,
        wants_kids,
        dietary_preference,
        relationship_goal,
        fitness_level,
        religion,
        sleep_schedule,
      },
      context
    ) => {
      verifyToken(context.token);
      try {
        const { rows } = await pool.query(
          `UPDATE lifestyle SET
            smoking = COALESCE($2, smoking),
            drinking = COALESCE($3, drinking),
            pets = COALESCE($4, pets),
            wants_kids = COALESCE($5, wants_kids),
            dietary_preference = COALESCE($6, dietary_preference),
            relationship_goal = COALESCE($7, relationship_goal),
            fitness_level = COALESCE($8, fitness_level),
            religion = COALESCE($9, religion),
            sleep_schedule = COALESCE($10, sleep_schedule)
          WHERE user_id = $1
          RETURNING *`,
          [
            user_id,
            smoking,
            drinking,
            pets,
            wants_kids,
            dietary_preference?.toLowerCase() || null,
            relationship_goal?.toLowerCase() || null,
            fitness_level?.toLowerCase() || null,
            religion?.toLowerCase() || null,
            sleep_schedule?.toLowerCase() || null,
          ]
        );

        if (!rows.length) {
          throw new GraphQLError("Lifestyle not found for update", {
            extensions: { code: "NOT_FOUND", statusCode: 404 },
          });
        }

        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to update lifestyle", {
          extensions: { code: "DB_ERROR", err },
        });
      }
    },

    deleteLifestyle: async (_, { user_id }, context) => {
      verifyToken(context.token);
      try {
        const { rows } = await pool.query(
          "DELETE FROM lifestyle WHERE user_id = $1 RETURNING *",
          [user_id]
        );
        if (!rows.length) {
          throw new GraphQLError("No lifestyle found to delete", {
            extensions: { code: "NOT_FOUND", statusCode: 404 },
          });
        }
        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to delete lifestyle", {
          extensions: { code: "DB_ERROR", err },
        });
      }
    },
  },
};

function verifyToken(token) {
  if (!token) {
    throw new GraphQLError("No token provided", {
      extensions: { code: "UNAUTHENTICATED", statusCode: 401 },
    });
  }
  jwt.verify(token, process.env.JWT_SECRET);
}

module.exports = {
  lifestyleTypeDefs,
  lifestyleResolvers,
};
