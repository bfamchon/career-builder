const express = require("express");
const path = require("path");
const helmet = require("helmet");

const app = express();

app.use(helmet());
app.use(express.static(path.join(__dirname, "build")));

app.get("/", function (req, res) {
  res.sendFile(path.join(__dirname, "build", "index.html"));
});

app.listen(process.env.PORT || 9000);
