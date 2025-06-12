const express = require("express");
const mongoose = require("mongoose");
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const Image = require("./image_schema");

const app = express();
const PORT = 3000;

// MongoDB connection
mongoose.connect("mongodb://localhost:27017/imageUploadDB");
mongoose.connection.once("open", () => {
  console.log("✅ Connected to MongoDB");
});

// Ensure 'uploads' folder exists
const uploadDir = path.join(__dirname, "uploads");
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// Multer storage setup
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/");
  },
  filename: function (req, file, cb) {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueName + path.extname(file.originalname));
  },
});
const upload = multer({ storage });

// Upload route
app.post("/upload", upload.single("image"), async (req, res) => {
  try {
    if (!req.file)
      return res.status(400).json({ message: "No image uploaded" });

    // Save metadata to MongoDB
    const newImage = new Image({
      filename: req.file.filename,
      path: `/uploads/${req.file.filename}`,
    });

    const savedImage = await newImage.save();

    res.status(201).json({
      message: "Image uploaded and saved to DB",
      image: savedImage,
    });
  } catch (err) {
    res.status(500).json({ error: "Server Error", details: err.message });
  }
});

// Serve static images
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
