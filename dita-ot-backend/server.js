// Required dependencies
const express = require("express");
const multer = require("multer");
const bodyParser = require("body-parser");
const fs = require("fs");
const path = require("path");
const cors = require("cors");
const archiver = require("archiver");

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Constants
// path for the default dita-OT
const DITA_PATH = path.join(__dirname, "public");
const UPLOAD_DIR = "./uploads/";
const upload = multer({ dest: UPLOAD_DIR });

// Helper function to generate color shades
// main logic for the take input color from user and create shades from that -->

const generateShades = (baseColor) => {
  const lightenOrDarken = (color, percent) => {
    const num = parseInt(color.slice(1), 16);
    const amt = Math.round(2.55 * percent);
    const R = (num >> 16) + amt;
    const G = ((num >> 8) & 0x00ff) + amt;
    const B = (num & 0x0000ff) + amt;
    return `#${(
      0x1000000 +
      (R < 255 ? (R < 1 ? 0 : R) : 255) * 0x10000 +
      (G < 255 ? (G < 1 ? 0 : G) : 255) * 0x100 +
      (B < 255 ? (B < 1 ? 0 : B) : 255)
    )
      .toString(16)
      .slice(1)}`;
  };

  return {
    primary0: lightenOrDarken(baseColor, 40),
    primary100: lightenOrDarken(baseColor, 30),
    primary200: lightenOrDarken(baseColor, 20),
    primary300: lightenOrDarken(baseColor, 10),
    primary400: baseColor,
    primary500: lightenOrDarken(baseColor, -10),
    primary600: lightenOrDarken(baseColor, -20),
    primary700: lightenOrDarken(baseColor, -30),
    primary800: lightenOrDarken(baseColor, -40),
    primary900: lightenOrDarken(baseColor, -50),
  };
};

// Endpoint to upload logo
// logic for the take input from user (logo) and replace to the dita ot plugin also changes the name
app.post("/upload", upload.single("logo"), (req, res) => {
  try {
    const headerColor = req.body.headerColor; // Read headerColor
    if (!headerColor) {
      return res.status(400).send("Header color is required.");
    }

    console.log("Header Color:", headerColor); // Log to check

    const logoPath = path.join(
      DITA_PATH,
      "ditaot_3.6.1-metr",
      "plugins",
      "com.metr.html5",
      "cfg",
      "common",
      "artwork",
      "html_logo",
      "Web_logo_W130xH65.png"
    );

    if (req.file) {
      console.log("Uploaded file:", req.file.path);

      const renamedFilePath = path.join(
        path.dirname(req.file.path),
        "Web_logo_W130xH65.png"
      );

      // Rename and copy the file
      // replace the name of that image file
      fs.renameSync(req.file.path, renamedFilePath);
      fs.copyFileSync(renamedFilePath, logoPath);
      console.log("Logo replaced successfully!");
    } else {
      return res.status(400).send("No logo file uploaded.");
    }

    // Modify the CSS file
    // logic for the replacing the custom color to the css file --->
    const cssFile = path.join(
      DITA_PATH,
      "ditaot_3.6.1-metr",
      "plugins",
      "com.metr.html5",
      "css",
      "custom.css"
    );

    // Read existing CSS file content
    let cssContent = fs.readFileSync(cssFile, "utf-8");

    // Generate new color shades based on the uploaded header color
    const shades = generateShades(headerColor);

    // Regex to capture :root block and replace color variables inside it
    const rootRegex = /:root\s*{([^}]*?)}/g;

    cssContent = cssContent.replace(rootRegex, (match, rootBlock) => {
      // Replace primary and secondary colors in the :root block
      let updatedRootBlock = rootBlock;

      // Update primary color variables
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-0:[^;]+;)/g,
        `--primary-0: ${shades.primary0};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-100:[^;]+;)/g,
        `--primary-100: ${shades.primary100};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-200:[^;]+;)/g,
        `--primary-200: ${shades.primary200};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-300:[^;]+;)/g,
        `--primary-300: ${shades.primary300};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-400:[^;]+;)/g,
        `--primary-400: ${shades.primary400};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-500:[^;]+;)/g,
        `--primary-500: ${shades.primary500};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-600:[^;]+;)/g,
        `--primary-600: ${shades.primary600};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-700:[^;]+;)/g,
        `--primary-700: ${shades.primary700};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-800:[^;]+;)/g,
        `--primary-800: ${shades.primary800};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--primary-900:[^;]+;)/g,
        `--primary-900: ${shades.primary900};`
      );

      // Update secondary color variables (if needed)
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-0:[^;]+;)/g,
        `--secondary-0: ${shades.primary0};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-100:[^;]+;)/g,
        `--secondary-100: ${shades.primary100};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-200:[^;]+;)/g,
        `--secondary-200: ${shades.primary200};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-300:[^;]+;)/g,
        `--secondary-300: ${shades.primary300};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-400:[^;]+;)/g,
        `--secondary-400: ${shades.primary400};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-500:[^;]+;)/g,
        `--secondary-500: ${shades.primary500};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-600:[^;]+;)/g,
        `--secondary-600: ${shades.primary600};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-700:[^;]+;)/g,
        `--secondary-700: ${shades.primary700};`
      );
      updatedRootBlock = updatedRootBlock.replace(
        /(--secondary-800:[^;]+;)/g,
        `--secondary-800: ${shades.primary800};`
      );

      // Update any other variables (like link hover color)
      updatedRootBlock = updatedRootBlock.replace(
        /(--bs-link-hover-color:[^;]+;)/g,
        `--bs-link-hover-color: ${shades.primary400} !important;`
      );

      return `:root {${updatedRootBlock}}`; // Return updated :root block
    });

    // Write the updated CSS content back to the file
    fs.writeFileSync(cssFile, cssContent, "utf-8");
    console.log("CSS updated successfully!");

    res.send("DITA-OT modified successfully!");
  } catch (err) {
    console.error("Error occurred:", err.message);
    res.status(500).send("An error occurred while processing the request.");
  }
});

// Endpoint to download the updated DITA-OT ____download the dita ot code
app.get("/download", (req, res) => {
  const zipFile = "./updated-dita-ot.zip";
  const output = fs.createWriteStream(zipFile);
  const archive = archiver("zip");

  output.on("close", () => {
    console.log(`${archive.pointer()} total bytes`);
    console.log(
      "Archive has been finalized and output file descriptor has closed."
    );
    res.download(zipFile); // Send the ZIP file for download
  });

  archive.on("error", (err) => {
    console.error("Error occurred while creating archive:", err.message);
    res.status(500).send("An error occurred while creating the archive.");
  });

  archive.pipe(output);
  archive.directory(DITA_PATH, false); // Update the path as needed
  archive.finalize();
});

// Start server
const PORT = 5000;
app.listen(PORT, () =>
  console.log(`Server running on http://localhost:${PORT}`)
);
