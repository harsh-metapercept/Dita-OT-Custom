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

// Function to find cover.xsl file
function findCoverXSL(dir, filename) {
  let result = null;
  const files = fs.readdirSync(dir);

  files.forEach((file) => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat.isDirectory()) {
      result = findCoverXSL(filePath, filename); // Recursively check subdirectories
    } else if (file === filename) {
      result = filePath; // Return the path when the file is found
    }
  });

  return result;
}

// Endpoint to update the title/heading in cover.xsl
app.post("/update-title", (req, res) => {
  const { newTitle } = req.body; // Read new title from the frontend input

  if (!newTitle || newTitle.trim() === "") {
    return res.status(400).send("Title is required.");
  }

  console.log("New Title:", newTitle); // Log for verification

  try {
    // Locate the `cover.xsl` file dynamically using the recursive function
    const coverXSLPath = findCoverXSL(
      path.join(DITA_PATH, "ditaot_3.6.1-metr", "plugins", "com.metr.html5"),
      "cover.xsl"
    );

    if (!coverXSLPath) {
      return res.status(404).send("cover.xsl file not found.");
    }

    // Read `cover.xsl` file content
    let coverXSLContent = fs.readFileSync(coverXSLPath, "utf-8");

    // Replace the placeholder title with the new title
    const titleRegex = /<span class="mainDitaMapTitle[^>]*>(.*?)<\/span>/;
    if (!titleRegex.test(coverXSLContent)) {
      return res.status(400).send("Title placeholder not found in cover.xsl.");
    }

    coverXSLContent = coverXSLContent.replace(
      titleRegex,
      `<span class="mainDitaMapTitle">${newTitle}</span>`
    );

    // Write the updated content back to `cover.xsl`
    fs.writeFileSync(coverXSLPath, coverXSLContent, "utf-8");

    console.log("cover.xsl updated successfully with new title!");
    res.send("Title updated successfully in cover.xsl!");
  } catch (err) {
    console.error("Error occurred:", err.message);
    res.status(500).send("An error occurred while updating the title.");
  }
});

// Function to get the current year
const getCurrentYear = () => {
  const year = new Date().getFullYear();
  console.debug("Current year dynamically fetched:", year);
  return year;
};

// Endpoint to update the footer
app.post("/update-footer", async (req, res) => {
  console.debug("Received request to update the footer with data:", req.body);

  const { companyName, companyWebsite } = req.body;

  if (!companyName || companyName.trim() === "") {
    console.error("Validation failed: Company name is missing.");
    return res.status(400).send("Company name is required.");
  }
  if (!companyWebsite || companyWebsite.trim() === "") {
    console.error("Validation failed: Company website is missing.");
    return res.status(400).send("Company website is required.");
  }

  try {
    console.debug("Locating file paths for updating the footer...");

    // Paths for the files to update
    const footerFile1 = path.join(
      DITA_PATH,
      "ditaot_3.6.1-metr",
      "plugins",
      "com.metr.html5",
      "xsl",
      "html5-bootstrap.xsl"
    );
    console.debug("Path to html5-bootstrap.xsl:", footerFile1);

    // Dynamically locate the cover.xsl file in the Customization folder
    const customizationDir = path.join(
      DITA_PATH,
      "ditaot_3.6.1-metr",
      "plugins",
      "com.metr.html5",
      "Customization"
    );
    console.debug("Searching for cover.xsl in directory:", customizationDir);

    const coverXSLPath = findCoverXSL(customizationDir, "cover.xsl");

    if (!coverXSLPath) {
      console.error("cover.xsl file not found in Customization directory.");
      return res.status(404).send("cover.xsl file not found.");
    }

    console.debug("cover.xsl file located at:", coverXSLPath);

    // Fetch current year for footer content
    const currentYear = getCurrentYear();
    console.debug("Using current year for the footer:", currentYear);

    // Footer content with dynamic year
    const footerContent = `<span class="credit ignore-this no-print">Copyright © ${currentYear} <a href="${companyWebsite.trim()}" target="_blank">${companyName.trim()}</a> All Rights Reserved</span>`;
    console.debug("Generated footer content:", footerContent);

    // Regex for both files
    const footerRegex =
      /<span class="credit ignore-this no-print">(.+?)<\/span>/s;

    // Function to update the footer in a file
    const updateFooterInFile = async (filePath, footerRegex, footerContent) => {
      console.debug(`Starting to update footer in file: ${filePath}`);
      try {
        if (!fs.existsSync(filePath)) {
          console.error(`File not found: ${filePath}`);
          throw new Error(`File not found: ${filePath}`);
        }

        let fileContent = fs.readFileSync(filePath, "utf-8");
        console.debug(
          `Read content from ${filePath}. Length: ${fileContent.length}`
        );

        const updatedContent = fileContent.replace(footerRegex, footerContent);
        console.debug(`Footer content updated in memory for file: ${filePath}`);

        fs.writeFileSync(filePath, updatedContent, "utf-8");
        console.debug(`Footer successfully written to file: ${filePath}`);
      } catch (err) {
        console.error(`Error updating footer in ${filePath}:`, err.message);
        throw new Error(`Error updating footer in ${filePath}`);
      }
    };

    // Update both files
    console.debug("Updating both files: html5-bootstrap.xsl and cover.xsl...");
    await Promise.all([
      updateFooterInFile(footerFile1, footerRegex, footerContent),
      updateFooterInFile(coverXSLPath, footerRegex, footerContent),
    ]);

    console.info("Footer updated successfully in both files!");
    res.send("Footer updated successfully in both files!");
  } catch (err) {
    console.error("Error during footer update:", err.message);
    res.status(500).send("An error occurred while updating the footer.");
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
