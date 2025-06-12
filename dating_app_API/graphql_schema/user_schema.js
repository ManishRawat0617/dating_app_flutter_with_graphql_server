const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const jwt = require("jsonwebtoken");
const { GraphQLError } = require("graphql");
const {
  hashPassword,
  comparePassword,
  generateToken,
  authenticate,
} = require("../middleware/middleware");
const { options } = require("ruru/cli");

const userTypeDefs = `
type User {
  id: ID!
  name: String
  email: String!
  password_hash: String!
  gender: String
  age: Int
  location: String
  bio: String
  occupation:String
  instagram_handle:String
  phone_number:String 
  created_at: String
}

type AuthPayload {
  user: User!
  token: String!
}

type Query {
  getAllUsers: [User!]
  getUserById(id: ID!): User
}

type Mutation {
  registerUser(
  
    email: String!
    password_hash: String!
   
  ): AuthPayload

  loginUser(
    email: String!
    password_hash: String!
  ): AuthPayload

  updateUser(
    id: ID!
    name: String
    email: String
    password_hash: String
    gender: String
    age: Int
    location: String
    bio: String
    occupation:String
    instagram_handle:String
  ): User

  deleteUser(id: ID!): User
}
`;

const userResolvers = {
  Query: {
    getAllUsers: async () => {
      try {
        const { rows } = await pool.query("SELECT * FROM users");
        return rows;
      } catch (err) {
        throw new GraphQLError("Fail to fetch the users", {
          extensions: {
            code: "FAIL TO FETCH",
            statusCode: 401,
          },
        });
      }
    },
    getUserById: async (_, args, context) => {
      id = args.id;

      try {
        const token = context.token;

        if (!token) {
          throw new GraphQLError("No token provided", {
            extensions: {
              code: "UNAUTHENTICATED",
              statusCode: 401,
            },
          });
        }

        jwt.verify(token, process.env.JWT_SECRET);

        const { rows } = await pool.query("SELECT * FROM users WHERE id = $1", [
          id,
        ]);

        return rows[0] || null;
      } catch (err) {
        throw new GraphQLError(
          "You are not authorized to access this resource",
          {
            extensions: {
              code: "UNAUTHENTICATED",
              statusCode: 401,
              err: err,
            },
          }
        );
      }
    },
  },

  Mutation: {
    registerUser: async (_, args) => {
      const { email, password_hash } = args;
      const id = uuidv4();
      const hashedPassword = await hashPassword(password_hash);

      try {
        const { rows } = await pool.query(
          `INSERT INTO users (id,  email, password_hash)
           VALUES ($1, $2, $3) RETURNING *`,
          [id, email.toLowerCase(), hashedPassword]
        );

        const user = rows[0];
        const token = generateToken(user.id, user.email);
        return { user, token };
      } catch (err) {
        throw new GraphQLError(
          "Registration failed. Email may already exist.",
          {
            extensions: {
              code: "FAILED",
              statusCode: 500,
            },
          }
        );
      }
    },

    loginUser: async (_, { email, password_hash }) => {
      try {
        const { rows } = await pool.query(
          "SELECT * FROM users WHERE email = $1",
          [email.toLowerCase()]
        );
        const user = rows[0];

        if (!user) throw new Error("User not found");

        const isValid = await comparePassword(
          password_hash,
          user.password_hash
        );
        if (!isValid)
          throw new GraphQLError("Email or password not matched ", {
            extensions: {
              code: "UNAUTHENTICATED",
              statusCode: 401,
              err: err,
            },
          });

        const token = generateToken(user.id, user.email);
        return { user, token };
      } catch (err) {
        throw new GraphQLError("login failed ", {
          extensions: {
            code: "UNAUTHENTICATED",
            statusCode: 401,
            err: err,
          },
        });
      }
    },

    updateUser: async (_, args, context) => {
      const {
        id,
        name,
        email,
        password_hash,
        gender,
        age,
        location,
        bio,
        occupation,
        instagram_handle,
      } = args;

      const hashedPassword = password_hash
        ? await hashPassword(password_hash)
        : null;

      try {
        const token = context.token;

        if (!token) {
          throw new GraphQLError("No token provided", {
            extensions: {
              code: "UNAUTHENTICATED",
              statusCode: 401,
            },
          });
        }
        const user = jwt.verify(token, process.env.JWT_SECRET);

        const { rows } = await pool.query(
          `UPDATE users SET
        name = COALESCE($2, name),
        email = COALESCE($3, email),
        password_hash = COALESCE($4, password_hash),
        gender = COALESCE($5, gender),
        age = COALESCE($6, age),
        location = COALESCE($7, location),
        bio = COALESCE($8, bio),
        occupation = COALESCE($9, occupation),
        instagram_handle = COALESCE($10, instagram_handle)
      WHERE id = $1
      RETURNING *`,
          [
            id,
            name ? name.toLowerCase() : null,
            email ? email.toLowerCase() : null,
            hashedPassword,
            gender ? gender.toLowerCase() : null,
            age,
            location ? location.toLowerCase() : null,
            bio,
            occupation ? occupation.toLowerCase() : null,
            instagram_handle ? instagram_handle.toLowerCase() : null,
          ]
        );
        return rows[0];
      } catch (err) {
        throw new GraphQLError("No token provided", {
          extensions: {
            code: "UNAUTHENTICATED",
            statusCode: 401,
            err: err,
          },
        });
      }
    },
    deleteUser: async (_, { id }, context) => {
      try {
        const token = context.token;

        if (!token) {
          throw new GraphQLError("No token provided", {
            extensions: {
              code: "UNAUTHENTICATED",
              statusCode: 401,
            },
          });
        }
        const user = jwt.verify(token, process.env.JWT_SECRET);

        const { rows } = await pool.query(
          "DELETE FROM users WHERE id = $1 RETURNING *",
          [id]
        );
        if (!rows.length) throw new Error("User not found");
        return rows[0];
      } catch (err) {
        throw new GraphQLError("No token provided", {
          extensions: {
            code: "UNAUTHENTICATED",
            statusCode: 401,
            err: err,
          },
        });
      }
    },
  },
};

module.exports = { userTypeDefs, userResolvers };
