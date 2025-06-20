const express = require("express");
const multer = require("multer");
const { uploadPhoto, getPhotosByUser, deletePhoto } = require("../controllers/photoController");

const router = express.Router();

// Multer setup
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const upload = multer({ storage });

router.post("/upload", upload.single("photo"), uploadPhoto);
router.get("/user/:user_id", getPhotosByUser);
router.delete("/:id", deletePhoto);

module.exports = router;
