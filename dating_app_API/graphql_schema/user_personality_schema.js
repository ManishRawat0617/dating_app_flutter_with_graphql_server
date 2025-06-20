const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const jwt = require("jsonwebtoken");
const { GraphQLError } = require("graphql");
const personalityTypeDefs = `
  type Personality {
    user_id: ID!
    personality_type: String
    zodiac_sign: String
    political_view: String
    love_language: String
    humor_style: String
    created_at: String
  }

  extend type Query {
    getAllPersonalities: [Personality!]
    getPersonalityByUserId(user_id: ID!): Personality
  }

  extend type Mutation {
    addPersonality(
      user_id: ID!
      personality_type: String
      zodiac_sign: String
      political_view: String
      love_language: String
      humor_style: String
    ): Personality

    updatePersonality(
      user_id: ID!
      personality_type: String
      zodiac_sign: String
      political_view: String
      love_language: String
      humor_style: String
    ): Personality

    deletePersonality(user_id: ID!): Personality
  }
`;

const personalityResolvers = {
  Query: {
    getAllPersonalities: async () => {
      const { rows } = await pool.query("SELECT * FROM personality");
      return rows;
    },
    getPersonalityByUserId: async (_, { user_id }) => {
      const { rows } = await pool.query(
        "SELECT * FROM personality WHERE user_id = $1",
        [user_id]
      );
      return rows[0] || null;
    },
  },

  Mutation: {
    addPersonality: async (
      _,
      {
        user_id,
        personality_type,
        zodiac_sign,
        political_view,
        love_language,
        humor_style,
      }
    ) => {
     
      try {
        const { rows } = await pool.query(
          `INSERT INTO personality (
            user_id, personality_type, zodiac_sign, political_view, 
            love_language, humor_style
          )
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING *`,
          [
            user_id,
            personality_type?.toLowerCase() || null,
            zodiac_sign?.toLowerCase() || null,
            political_view?.toLowerCase() || null,
            love_language?.toLowerCase() || null,
            humor_style?.toLowerCase() || null,
          ]
        );
        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to add personality", {
          extensions: { code: "DB_ERROR", err },
        });
      }
    },

    updatePersonality: async (
      _,
      {
        user_id,
        personality_type,
        zodiac_sign,
        political_view,
        love_language,
        humor_style,
      },
      context
    ) => {
      verifyToken(context.token);
      try {
        const { rows } = await pool.query(
          `UPDATE personality SET
            personality_type = COALESCE($2, personality_type),
            zodiac_sign = COALESCE($3, zodiac_sign),
            political_view = COALESCE($4, political_view),
            love_language = COALESCE($5, love_language),
            humor_style = COALESCE($6, humor_style)
          WHERE user_id = $1
          RETURNING *`,
          [
            user_id,
            personality_type?.toLowerCase() || null,
            zodiac_sign?.toLowerCase() || null,
            political_view?.toLowerCase() || null,
            love_language?.toLowerCase() || null,
            humor_style?.toLowerCase() || null,
          ]
        );
        if (!rows.length) {
          throw new GraphQLError("Personality not found for update", {
            extensions: { code: "NOT_FOUND", statusCode: 404 },
          });
        }
        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to update personality", {
          extensions: { code: "DB_ERROR", err },
        });
      }
    },

    deletePersonality: async (_, { user_id }, context) => {
      verifyToken(context.token);
      try {
        const { rows } = await pool.query(
          "DELETE FROM personality WHERE user_id = $1 RETURNING *",
          [user_id]
        );
        if (!rows.length) {
          throw new GraphQLError("No personality found to delete", {
            extensions: { code: "NOT_FOUND", statusCode: 404 },
          });
        }
        return rows[0];
      } catch (err) {
        throw new GraphQLError("Failed to delete personality", {
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
  personalityTypeDefs,
  personalityResolvers,
};
