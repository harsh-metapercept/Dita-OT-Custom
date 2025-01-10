import React, { useState, useEffect } from "react";
import { ChromePicker } from "react-color";

const ThemeEditor = ({
  primaryColor,
  setPrimaryColor,
  logoFile,
  setLogoFile,
  handleNextSection,
}) => {
  const [previewUrl, setPreviewUrl] = useState(null);
  const [error, setError] = useState(null);

  const handleLogoChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const allowedTypes = ["image/png", "image/jpeg"];
      const maxSize = 5 * 1024 * 1024; // 5MB size limit

      if (allowedTypes.includes(file.type)) {
        if (file.size <= maxSize) {
          setLogoFile(file);
          const preview = URL.createObjectURL(file);
          setPreviewUrl(preview);
          setError(null);
        } else {
          setError("File size exceeds the 5MB limit.");
        }
      } else {
        setError("Invalid file type. Please upload a PNG or JPEG image.");
      }
    }
  };

  useEffect(() => {
    return () => {
      if (previewUrl) URL.revokeObjectURL(previewUrl);
    };
  }, [previewUrl]);

  return (
    <div className="bg-white p-6 rounded-lg shadow-lg max-w-md mx-auto">
      <h2 className="text-2xl font-semibold mb-4 text-center">🎨 Theme Editor</h2>
      <div className="mb-6">
        <h3 className="text-xl font-semibold mb-4">Pick Primary Color</h3>
        <ChromePicker
          color={primaryColor}
          onChange={(color) => setPrimaryColor(color.hex)}
          disableAlpha
        />
      </div>
      <div className="relative mb-4">
        <input
          type="file"
          accept="image/png, image/jpeg"
          onChange={handleLogoChange}
          className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
        />
        <button className="w-full px-6 py-3 bg-blue-400 text-white rounded-lg shadow hover:bg-indigo-500">
          Choose File
        </button>
      </div>
      {error && <p className="text-red-500">{error}</p>}
      {previewUrl && <img src={previewUrl} alt="Logo Preview" className="mt-4" />}
      <button
        onClick={handleNextSection}
        className="mt-4 bg-blue-400 text-white px-6 py-2 rounded hover:bg-blue-600"
      >
        Next
      </button>
    </div>
  );
};

export default ThemeEditor;
