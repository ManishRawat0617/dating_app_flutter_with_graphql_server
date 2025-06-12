require("dotenv").config();
const express = require("express");
const { createYoga } = require("graphql-yoga");
require("./config/database/mongoDB");
const createTables = require("./config/table/table");
const { schema } = require("./controller/schema");
const jwt = require("jsonwebtoken");
const authenticateToken = require("./middleware/authentication");

const port = process.env.PORT || 4000;
createTables(); // Ensure tables are created

const app = express();
app.use(express.json());

// app.use(authenticateToken);

const yoga = createYoga({
  schema,
  context: ({ request }) => {
    const authHeader = request.headers.get("authorization") || "";
    const token = authHeader.replace("Bearer ", "");

    // let user = null;
    // let tokenError = null;

    // if (token) {
    //   try {
    //     user = jwt.verify(token, process.env.JWT_SECRET);
    //   } catch (err) {
    //     tokenError = "Invalid or expired token";
    //   }
    // }

    return { token };
  },
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
