import React, { useState } from "react";
import { ChromePicker } from "react-color";
import axios from "axios";

const App = () => {
  const [primaryColor, setPrimaryColor] = useState("#ffffff");
  const [logoFile, setLogoFile] = useState(null);
  const [uploadMessage, setUploadMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async () => {
    if (!primaryColor || !logoFile) {
      setUploadMessage("Please select a primary color and upload a logo file.");
      return;
    }

    const formData = new FormData();
    formData.append("headerColor", primaryColor);
    formData.append("logo", logoFile);

    setIsLoading(true);
    setUploadMessage(""); // Reset any previous messages

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

      {/* Buttons */}
      <div style={{ display: "flex", justifyContent: "center", gap: "10px" }}>
        <button
          onClick={handleSubmit}
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
          onClick={() => {
            setPrimaryColor("#ffffff");
            setLogoFile(null);
            setUploadMessage("");
          }}
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
