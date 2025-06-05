// require("dotenv").config();
// const express = require("express");
// const { createYoga } = require("graphql-yoga");
// require("./config/database/mongoDB");
// const createTables = require("./config/table/table");
// const { schema } = require("./controller/schema");
// const authenticateToken = require("./authMiddleware");

// const port = process.env.PORT || 4000;

// createTables(); // Create PostgreSQL tables

// const app = express();
// app.use(express.json());
// app.use(authenticateToken);
// // Initialize Yoga GraphQL server with context support
// const yoga = createYoga({
//   schema,
//   context: ({ request }) => ({ req: request }), // make req available in resolvers
// });

// // GraphQL endpoint
// app.use("/graphql", yoga);

// // Optional: serve a landing page
// app.get("/", (req, res) => {
//   res.send(`
//     <html>
//       <head><title>GraphQL Server</title></head>
//       <body>
//         <h1>Welcome to your GraphQL API</h1>
//         <p>Access GraphQL Playground at <a href="/graphql">/graphql</a></p>
//       </body>
//     </html>
//   `);
// });

// // Start server
// app.listen(port, () => {
//   console.log(`🚀 Server running at http://localhost:${port}/graphql`);
// });

require("dotenv").config();
const express = require("express");
const { createYoga } = require("graphql-yoga");
require("./config/database/mongoDB");
const createTables = require("./config/table/table");
const { schema } = require("./controller/schema");
const jwt = require("jsonwebtoken");

const port = process.env.PORT || 4000;
createTables(); // Ensure tables are created

const app = express();
app.use(express.json());

app.use((req, res, next) => {
  const authHeader = req.headers.authorization;
  if (authHeader) {
    const token = authHeader.split(" ")[1]; // Expecting "Bearer <token>"
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded; // Attach user info to request
    } catch (err) {
      console.warn("Invalid or expired token");
    }
  }
  next();
});

const yoga = createYoga({
  schema,
  context: ({ request }) => ({
    req: request,
    user: request.user, // user will be available in resolvers
  }),
});

app.use("/graphql", yoga);

app.get("/", (req, res) => {
  res.send(`
    <html>
      <head><title>GraphQL Server</title></head>
      <body>
        <h1>Welcome to your GraphQL API</h1>
        <p>Access GraphQL Playground at <a href="/graphql">/graphql</a></p>
      </body>
    </html>
  `);
});

app.listen(port, () => {
  console.log(`🚀 Server running at http://localhost:${port}/graphql`);
});
