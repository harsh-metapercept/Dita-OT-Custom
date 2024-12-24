import React, { useState } from "react";
import { ChromePicker } from "react-color";
import axios from "axios";

const App = () => {
  const [primaryColor, setPrimaryColor] = useState("#ffffff");
  const [logoFile, setLogoFile] = useState(null);
  const [companyName, setCompanyName] = useState("");
  const [companyWebsite, setCompanyWebsite] = useState("");
  const [uploadMessage, setUploadMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleApplyChanges = async () => {
    if (!primaryColor || !logoFile) {
      setUploadMessage("Please select a primary color and upload a logo file.");
      return;
    }

    const formData = new FormData();
    formData.append("headerColor", primaryColor);
    formData.append("logo", logoFile);

    setIsLoading(true);
    setUploadMessage("");

    try {
      const response = await axios.post(
        "http://localhost:5000/upload",
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );
      setUploadMessage("Changes applied successfully!");
      console.log("Response:", response.data);
    } catch (error) {
      setUploadMessage("An error occurred while applying changes.");
      console.error("Error uploading:", error.message);
    } finally {
      setIsLoading(false);
    }
  };

  const handleUpdateFooter = async () => {
    if (!companyName.trim() || !companyWebsite.trim()) {
      setUploadMessage("Company name and website cannot be empty.");
      return;
    }

    try {
      const response = await axios.post("http://localhost:5000/update-footer", {
        companyName,
        companyWebsite,
      });
      setUploadMessage("Footer updated successfully!");
      console.log("Response:", response.data);
    } catch (error) {
      setUploadMessage("An error occurred while updating the footer.");
      console.error("Error updating footer:", error.message);
    }
  };

  const handleDownload = async () => {
    try {
      const response = await axios.get("http://localhost:5000/download", {
        responseType: "blob",
      });
      const link = document.createElement("a");
      link.href = URL.createObjectURL(response.data);
      link.download = "updated-dita-ot.zip";
      link.click();
    } catch (error) {
      console.error("Error downloading:", error.message);
      setUploadMessage("An error occurred while downloading.");
    }
  };

  const handleReset = () => {
    setPrimaryColor("#ffffff");
    setLogoFile(null);
    setCompanyName("");
    setCompanyWebsite("");
    setUploadMessage("");
  };

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2 style={{ textAlign: "center" }}>DITA-OT Customization Tool</h2>

      {/* Primary Color Picker */}
      <div style={{ marginBottom: "20px" }}>
        <label htmlFor="primaryColor" style={{ fontWeight: "bold" }}>
          Pick Primary Color:
        </label>
        <ChromePicker
          color={primaryColor}
          onChange={(color) => setPrimaryColor(color.hex)}
          disableAlpha
          style={{ marginTop: "10px" }}
        />
      </div>

      {/* Logo File Input */}
      <div style={{ marginBottom: "20px" }}>
        <label htmlFor="logoFile" style={{ fontWeight: "bold" }}>
          Upload Logo:
        </label>
        <input
          id="logoFile"
          type="file"
          accept="image/png"
          onChange={(e) => setLogoFile(e.target.files[0])}
          style={{ marginTop: "10px" }}
        />
      </div>

      {/* Footer Customization Section */}
      <div style={{ marginBottom: "20px" }}>
        <h3 style={{ fontWeight: "bold" }}>Footer Customization</h3>

        {/* Company Name Input */}
        <div style={{ marginBottom: "20px" }}>
          <label htmlFor="companyName" style={{ fontWeight: "bold" }}>
            Company Name:
          </label>
          <input
            id="companyName"
            type="text"
            value={companyName}
            onChange={(e) => setCompanyName(e.target.value)}
            placeholder="Enter company name"
            style={{
              width: "100%",
              marginTop: "10px",
              padding: "10px",
              border: "1px solid #ccc",
              borderRadius: "5px",
            }}
          />
        </div>

        {/* Company Website Input */}
        <div style={{ marginBottom: "20px" }}>
          <label htmlFor="companyWebsite" style={{ fontWeight: "bold" }}>
            Company Website:
          </label>
          <input
            id="companyWebsite"
            type="url"
            value={companyWebsite}
            onChange={(e) => setCompanyWebsite(e.target.value)}
            placeholder="Enter company website"
            style={{
              width: "100%",
              marginTop: "10px",
              padding: "10px",
              border: "1px solid #ccc",
              borderRadius: "5px",
            }}
          />
        </div>
      </div>

      {/* Buttons */}
      <div style={{ display: "flex", justifyContent: "center", gap: "10px" }}>
        <button
          onClick={handleApplyChanges}
          style={{
            padding: "10px 20px",
            backgroundColor: primaryColor,
            color: "#fff",
            border: "none",
            borderRadius: "5px",
            cursor: "pointer",
            fontWeight: "bold",
          }}
          disabled={isLoading}
        >
          {isLoading ? "Applying..." : "Apply Changes"}
        </button>
        <button
          onClick={handleUpdateFooter}
          style={{
            padding: "10px 20px",
            backgroundColor: "#007BFF",
            color: "#fff",
            border: "none",
            borderRadius: "5px",
            cursor: "pointer",
            fontWeight: "bold",
          }}
        >
          Update Footer
        </button>
        <button
          onClick={handleReset}
          style={{
            padding: "10px 20px",
            backgroundColor: "#ccc",
            color: "#000",
            border: "none",
            borderRadius: "5px",
            cursor: "pointer",
            fontWeight: "bold",
          }}
        >
          Reset
        </button>
        <button
          onClick={handleDownload}
          style={{
            padding: "10px 20px",
            backgroundColor: "#4CAF50",
            color: "#fff",
            border: "none",
            borderRadius: "5px",
            cursor: "pointer",
            fontWeight: "bold",
          }}
        >
          Download Updated DITA-OT
        </button>
      </div>

      {/* Feedback Message */}
      {uploadMessage && (
        <div
          style={{
            marginTop: "20px",
            textAlign: "center",
            color: uploadMessage.includes("successfully") ? "green" : "red",
          }}
        >
          {uploadMessage}
        </div>
      )}
    </div>
  );
};

export default App;
