const express = require("express");
const path = require("path");
const photoRoutes = require("./routes/photoRoutes");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use("/api/photos", photoRoutes);

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
