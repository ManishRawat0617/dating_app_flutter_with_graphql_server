const { v4: uuidv4 } = require("uuid");
const pool = require("../config/database");

exports.uploadPhoto = async (req, res) => {
  const { user_id } = req.body;
  const is_profile = req.body.is_profile === "true";

  if (!req.file) return res.status(400).json({ error: "No file uploaded" });

  const url = `/uploads/${req.file.filename}`;

  try {
    const id = uuidv4(); 
    const result = await pool.query(
      `INSERT INTO photos (id, user_id, url, is_profile)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [id, user_id, url, is_profile]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) { 
    console.error("Upload error", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.getPhotosByUser = async (req, res) => {
  const { user_id } = req.params;

  try {
    const result = await pool.query(
      `SELECT * FROM photos WHERE user_id = $1 `,
      [user_id]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Fetch error", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.deletePhoto = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      `DELETE FROM photos WHERE id = $1 RETURNING *`,
      [id]
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Photo not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error("Delete error", err);
    res.status(500).json({ error: "Internal server error" });
  }
};
