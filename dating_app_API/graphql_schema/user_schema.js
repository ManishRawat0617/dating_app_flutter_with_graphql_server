// // user.js

// const { v4: uuidv4 } = require("uuid");
// const pool = require("../config/database/postgreSQL");
// const bcrypt = require("bcrypt");
// const {
//   hashPassword,
//   comparePassword,
//   generateToken,
//   authenticate,
// } = require("../middleware/middleware");
// const { request } = require("express");

// // GraphQL type definitions
// const userTypeDefs = `
// type User {
//   id: ID!
//   name: String!
//   email: String!
//   password_hash: String!
//   gender: String
//   age: Int
//   location: String
//   bio: String
//   created_at: String
// }

// type AuthPayload {
//   user: User!
//   token: String!
// }

// type Query {
//   getAllUsers: [User!]
//   getUserById(id: ID!): User
// }

// type Mutation {
//   registerUser(
//     name: String,
//     email: String!,
//     password_hash: String!,
//     gender: String,
//     age: Int,
//     location: String,
//     bio: String
//   ): AuthPayload

//   loginUser(
//     email: String!,
//     password_hash: String!
//   ): AuthPayload

//   updateUser(
//     id: ID!,
//     name: String,
//     email: String,
//     password_hash: String,
//     gender: String,
//     age: Int,
//     location: String,
//     bio: String
//   ): User

//   deleteUser(id: ID!): User
// }
// `;

// // Resolvers
// const userResolvers = {
//   Query: {
//     getAllUsers: async () => {
//       try {
//         const { rows } = await pool.query("SELECT * FROM users");
//         return rows;
//       } catch (err) {
//         throw new Error("Failed to fetch users");
//       }
//     },

//     getUserById: async (_, { id }) => {
//       try {
//         const { rows } = await pool.query("SELECT * FROM users WHERE id = $1", [
//           id,
//         ]);
//         return rows[0] || null;
//       } catch (err) {
//         throw new Error("Failed to fetch user");
//       }
//     },
//   },

//   Mutation: {
//     registerUser: async (_, args) => {
//       const { name, email, password_hash, gender, age, location, bio } = args;
//       const id = uuidv4();
//       const hashedPassword = await hashPassword(password_hash);

//       try {
//         const { rows } = await pool.query(
//           `INSERT INTO users (id, name, email, password_hash, gender, age, location, bio)
//            VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
//           [id, name, email, hashedPassword, gender, age, location, bio]
//         );

//         const user = rows[0];
//         const token = generateToken(user.id, user.email);
//         if (!user) throw new Error("User registration failed");
//         return { user, token };
//       } catch (err) {
//         throw new Error("Registration failed. Email may already exist.");
//       }
//     },

//     loginUser: async (_, { email, password_hash }) => {
//       try {
//         const { rows } = await pool.query(
//           "SELECT * FROM users WHERE email = $1",
//           [email]
//         );
//         const user = rows[0];

//         if (!user) throw new Error("User not found");

//         const isValid = await comparePassword(
//           password_hash,
//           user.password_hash
//         );
//         if (!isValid) throw new Error("Invalid email or password");

//         const token = generateToken(user.id, user.email);
//         console.log("Generated token:", authenticate(token));
//         return { user, token };
//       } catch (err) {
//         throw new Error(err.message || "Login failed");
//       }
//     },

//     updateUser: async (_, args, context) => {
//       // const authHeader = context.headers.authorization;
//       const authHeader = context.req.headers;
//       const bearerToken = authHeader;

//       // let token;
//       // if (bearerToken && bearerToken.startsWith('Bearer ')) {
//       //   token = bearerToken.split(' ')[1]; // removes 'Bearer '
//       // }

//       // console.log("Extracted token:", bearerToken);

//       // const { id: tokenUserId } = authenticate(authHeader);

//       const { id, name, email, password_hash, gender, age, location, bio } =
//         args;

//       // if (id !== tokenUserId) {
//       //   throw new Error("Unauthorized: You can only update your own account");
//       // }

//       const hashedPassword = password_hash
//         ? await hashPassword(password_hash)
//         : null;

//       try {
//         const { rows } = await pool.query(
//           `UPDATE users SET
//             name = COALESCE($2, name),
//             email = COALESCE($3, email),
//             password_hash = COALESCE($4, password_hash),
//             gender = COALESCE($5, gender),
//             age = COALESCE($6, age),
//             location = COALESCE($7, location),
//             bio = COALESCE($8, bio)
//            WHERE id = $1
//            RETURNING *`,
//           [id, name, email, hashedPassword, gender, age, location, bio]
//         );
//         return rows[0];
//       } catch (err) {
//         throw new Error("Update failed");
//       }
//     },

//     deleteUser: async (_, { id, context }) => {
//       try {
//         console.log("Context user:", user);
//         if (!context.user) {
//           throw new Error("Unauthorized");
//         }

//         // Optional: Ensure user is updating their own profile
//         if (context.user.id !== args.id) {
//           throw new Error("Forbidden");
//         }
//         const { rows } = await pool.query(
//           "DELETE FROM users WHERE id = $1 RETURNING *",
//           [id]
//         );
//         if (!rows.length) throw new Error("User not found");
//         return rows[0];
//       } catch (err) {
//         throw new Error("Deletion failed");
//       }
//     },
//   },
// };

// module.exports = { userTypeDefs, userResolvers };

const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database/postgreSQL");
const {
  hashPassword,
  comparePassword,
  generateToken,
  authenticate,
} = require("../middleware/middleware");

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
    name: String
    email: String!
    password_hash: String!
    gender: String
    age: Int
    location: String
    bio: String
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
        throw new Error("Failed to fetch users");
      }
    },

    getUserById: async (_, { id }) => {
      try {
        const { rows } = await pool.query("SELECT * FROM users WHERE id = $1", [
          id,
        ]);
        return rows[0] || null;
      } catch (err) {
        throw new Error("Failed to fetch user");
      }
    },
  },

  Mutation: {
    registerUser: async (_, args) => {
      const { name, email, password_hash, gender, age, location, bio } = args;
      const id = uuidv4();
      const hashedPassword = await hashPassword(password_hash);

      try {
        const { rows } = await pool.query(
          `INSERT INTO users (id, name, email, password_hash, gender, age, location, bio)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
          [
            id,
            name.toLowerCase(),
            email.toLowerCase(),
            hashedPassword,
            gender.toLowerCase(),
            age,
            location.toLowerCase(),
            bio,
          ]
        );

        const user = rows[0];
        const token = generateToken(user.id, user.email);
        return { user, token };
      } catch (err) {
        throw new Error("Registration failed. Email may already exist.");
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
        if (!isValid) throw new Error("Invalid email or password");

        const token = generateToken(user.id, user.email);
        return { user, token };
      } catch (err) {
        throw new Error(err.message || "Login failed");
      }
    },

    updateUser: async (_, args, context) => {
      const { id, name, email, password_hash, gender, age, location, bio } =
        args;

      // Optional: Require authentication
      if (!context.user || context.user.id !== id) {
        throw new Error("Unauthorized: You can only update your own account");
      }

      const hashedPassword = password_hash
        ? await hashPassword(password_hash)
        : null;

      try {
        const { rows } = await pool.query(
          `UPDATE users SET
            name = COALESCE($2, name),
            email = COALESCE($3, email),
            password_hash = COALESCE($4, password_hash),
            gender = COALESCE($5, gender),
            age = COALESCE($6, age),
            location = COALESCE($7, location),
            bio = COALESCE($8, bio)
           WHERE id = $1
           RETURNING *`,
          [
            id,
            name.toLowerCase(),
            email.tolowerCase(),
            hashedPassword,
            gender.toLowerCase(),
            age,
            location.toLowerCase(),
            bio,
          ]
        );
        return rows[0];
      } catch (err) {
        throw new Error("Update failed");
      }
    },

    deleteUser: async (_, { id }, context) => {
      try {
        if (!context.user) {
          throw new Error("Unauthorized");
        }

        if (context.user.id !== id) {
          throw new Error("Forbidden");
        }

        const { rows } = await pool.query(
          "DELETE FROM users WHERE id = $1 RETURNING *",
          [id]
        );
        if (!rows.length) throw new Error("User not found");
        return rows[0];
      } catch (err) {
        throw new Error("Deletion failed");
      }
    },
  },
};

module.exports = { userTypeDefs, userResolvers };
