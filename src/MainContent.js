import React, { useState, useEffect } from "react";
import { ChromePicker } from "react-color";
import preview1 from "./assets/preview1.jpg";
import preview2 from "./assets/preview2.png";
import preview3 from "./assets/preview3.png";

const MainContent = ({
  activeSection,
  primaryColor,
  setPrimaryColor,
  logoFile,
  setLogoFile,
  companyName,
  setCompanyName,
  companyWebsite,
  setCompanyWebsite,
  handleApplyChanges,
  handleUpdateFooter,
  handleDownload,
  handleReset,
  uploadMessage,
  isLoading,
  handleNextSection,
  handlePreviousSection,
}) => {
  const [headerText, setHeaderText] = useState("");
  const [previewUrl, setPreviewUrl] = useState(null);
  const [error, setError] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

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
          setLogoFile(null);
          setPreviewUrl(null);
        }
      } else {
        setError("Invalid file type. Please upload a PNG or JPEG image.");
        setLogoFile(null);
        setPreviewUrl(null);
      }
    } else {
      setLogoFile(null);
      setPreviewUrl(null);
    }
  };

  const handleOpenModal = () => setIsModalOpen(true);

  const handleCloseModal = () => setIsModalOpen(false);

  useEffect(() => {
    return () => {
      if (previewUrl) {
        URL.revokeObjectURL(previewUrl);
      }
    };
  }, [previewUrl]);

  const renderSectionContent = () => {
    switch (activeSection) {
      case 1:
        return (
          <div className="bg-transparent p-8 max-w-3xl mx-auto">
            <h2 className="text-3xl font-semibold mb-6 text-left text-blue-400">
              🌟 Introduction
            </h2>
            <p className="text-lg text-gray-700 mt-6 text-left">
              This tool simplifies working with DITA-OT by providing a
              user-friendly interface to edit plugin files, ensuring seamless
              integration with your existing setup.
            </p>
            <br />
            <ul className="text-lg text-gray-700 space-y-4 pl-6 list-disc text-left">
              <li>
                <strong>Effortless Customization:</strong> Modify your DITA-OT
                HTML plugin with ease.
              </li>
              <li>
                <strong>Theme Customization:</strong> Change theme colors to
                suit your preference.
              </li>
              <li>
                <strong>Upload Logos:</strong> Add custom logos to personalize
                your plugin.
              </li>
              <li>
                <strong>Header & Footer:</strong> Edit header and footer designs
                seamlessly, including adding copyrights to the footer.
              </li>
              <li>
                <strong>Navigation Panel:</strong> Configure navigation
                features, including breadcrumbs, next/previous links, side
                menus, and menu appearance with logo integration.
              </li>
              <li>
                <strong>Icons and Button Designs:</strong> Customize iconography
                and button styles to align with your design preferences.
              </li>
              <li>
                <strong>Download Ready:</strong> Export the updated plugin for
                immediate use.
              </li>
            </ul>

            <br />

            <h5 className="text-lg font-semibold mb-6 text-left text-blue-400">
              preview of html5 plugin landing page :
            </h5>

            <div className="mt-8 flex justify-center relative">
              <img
                src={preview1}
                alt="HTML Plugin Details"
                className="max-w-2xl max-h-96 object-contain border-4 border-white rounded-xl shadow-md"
              />
              <button
                onClick={handleOpenModal}
                className="absolute bottom-4 right-4 bg-blue-500 text-white px-4 py-2 rounded-full opacity-0 hover:opacity-100 transition-opacity duration-300"
              >
                Preview
              </button>
            </div>

            {isModalOpen && (
              <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
                <div className="bg-white p-8 rounded-lg shadow-lg">
                  <div className="flex justify-end">
                    <button
                      onClick={handleCloseModal}
                      className="text-red-500 text-2xl"
                    >
                      &times;
                    </button>
                  </div>
                  <img
                    src={preview1}
                    alt="Full HTML Plugin Details"
                    className="max-w-3xl max-h-96 object-contain"
                  />
                </div>
              </div>
            )}

            <div className="flex gap-4 mt-8 justify-center">
              <button
                onClick={handleNextSection}
                className="bg-blue-500 text-white px-6 py-2 rounded-lg shadow-md hover:bg-blue-600 transition-transform duration-300 transform hover:scale-105"
              >
                Next
              </button>
            </div>
          </div>
        );
      case 2:
        return (
          <div className=" p-6 max-w-md mx-auto">
            <h2 className="text-2xl font-bold mb-4 text-center">
              🎨 Theme Editor
            </h2>
            <div className="mb-6">
              <h3 className="text-lg font-semibold mb-3">Pick Primary Color</h3>
              <ChromePicker
                color={primaryColor}
                onChange={(color) => setPrimaryColor(color.hex)}
                disableAlpha
              />
            </div>

            <div className="mt-6">
              <h3 className="text-lg font-semibold mb-3">Preview Changes :</h3>
              <img
                src={preview2}
                alt="Theme Preview"
                className="w-full h-auto object-contain rounded-lg border border-gray-300"
              />
              <ul>
                <li className="text-gray-600 mt-3 text-md">
                  The preview above shows how the primary color will affect
                  buttons, headers, anchor tags, links, table header, table
                  background color and all H tags.
                </li>
              </ul>
            </div>

            <div className="flex gap-4 mt-6 justify-center">
              <button
                onClick={handlePreviousSection}
                className="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600 transition-transform transform hover:scale-105"
              >
                Previous
              </button>
              <button
                onClick={handleNextSection}
                className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition-transform transform hover:scale-105"
              >
                Next
              </button>
            </div>
          </div>
        );
      case 3:
        return (
          <div className="bg-white p-6 rounded-lg max-w-auto mx-auto">
            <div className="bg-white p-6 rounded-lg max-w-lg mx-auto">
              <h2 className="text-2xl font-semibold mb-6 text-center">
                🖼️ Header Customization
              </h2>
              <div className="mb-6">
                <label className="block font-semibold text-gray-700 mb-2">
                  Header Text:
                </label>
                <input
                  type="text"
                  value={headerText}
                  onChange={(e) => setHeaderText(e.target.value)}
                  placeholder="Enter header text"
                  className="block w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              <div className="mb-6">
                <h3 className="text-xl font-semibold mb-4">🖼️ Upload Logo</h3>
                <div className="relative mb-4">
                  <input
                    type="file"
                    accept="image/png, image/jpeg"
                    onChange={handleLogoChange}
                    className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
                  />
                  <button className="w-full px-6 py-3 bg-blue-400 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 transition">
                    Choose File
                  </button>
                </div>
                {logoFile && !error && (
                  <p className="mt-4 text-sm font-medium bg-indigo-100 text-indigo-800 px-4 py-2 rounded-lg shadow">
                    {logoFile.name} selected
                  </p>
                )}
                {error && (
                  <p className="mt-4 text-sm font-medium bg-red-100 text-red-600 px-4 py-2 rounded-lg shadow">
                    {error}
                  </p>
                )}
                {previewUrl && !error && (
                  <div className="mt-6 flex flex-col items-center">
                    <h3 className="text-lg font-semibold mb-2">
                      Logo Preview:
                    </h3>
                    <img
                      src={previewUrl}
                      alt="Logo Preview"
                      className="max-w-full max-h-48 object-contain border-4 border-white rounded-xl shadow-md"
                    />
                  </div>
                )}
              </div>
            </div>

            <div className="mt-6">
              <h3 className="text-lg font-semibold mb-3">Preview Changes :</h3>
              <div className="flex flex-col justify-center items-center">
                <img
                  src={preview3}
                  alt="Theme Preview"
                  className="w-74 h-auto rounded-lg border border-gray-300"
                />
                <ul className="text-center">
                  <li className="text-gray-600 mt-3 text-md">
                    The preview above shows how the primary color will affect
                    buttons, headers, anchor tags, links, table header, table
                    background color, and all H tags.
                  </li>
                </ul>
              </div>
            </div>

            <div className="flex gap-4 mt-6 justify-center">
              <button
                onClick={handlePreviousSection}
                className="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Previous
              </button>
              <button
                onClick={handleNextSection}
                className="bg-blue-400 text-white px-6 py-2 rounded hover:bg-blue-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Next
              </button>
            </div>
          </div>
        );
      case 4:
        return (
          <div className="bg-white p-6 rounded-lg max-w-lg mx-auto">
            <h2 className="text-2xl font-semibold mb-6 text-center">
              🖼️ Footer Customization
            </h2>
            <div className="mb-6">
              <label className="block font-semibold text-gray-700 mb-2">
                Company Name:
              </label>
              <input
                type="text"
                value={companyName}
                onChange={(e) => setCompanyName(e.target.value)}
                placeholder="Enter company name"
                className="block w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div className="mb-6">
              <label className="block font-semibold text-gray-700 mb-2">
                Company Website:
              </label>
              <input
                type="url"
                value={companyWebsite}
                onChange={(e) => setCompanyWebsite(e.target.value)}
                placeholder="Enter company website"
                className="block w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div className="flex gap-4 mt-6 justify-center">
              <button
                onClick={handlePreviousSection}
                className="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Previous
              </button>
              <button
                onClick={handleNextSection}
                className="bg-blue-400 text-white px-6 py-2 rounded hover:bg-blue-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Next
              </button>
            </div>
          </div>
        );
      case 5:
        return (
          <div className="bg-white p-6 rounded-lg max-w-lg mx-auto">
            <h2 className="text-2xl font-semibold mb-6 text-center">
              ⚙️ Final Customization
            </h2>
            <div className="flex gap-4 mt-6 justify-center">
              <button
                onClick={handleApplyChanges}
                className={`px-6 py-2 font-semibold text-white rounded-lg ${
                  isLoading
                    ? "bg-gray-400 cursor-not-allowed"
                    : "bg-blue-500 hover:bg-blue-600 transition duration-300 ease-in-out transform hover:scale-105"
                }`}
                disabled={isLoading}
              >
                {isLoading ? "Applying..." : "Apply Changes"}
              </button>
              <button
                onClick={handleUpdateFooter}
                className="px-6 py-2 font-semibold text-white bg-green-500 rounded-lg hover:bg-green-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Update Footer
              </button>
              <button
                onClick={handleReset}
                className="px-6 py-2 font-semibold text-white bg-red-500 rounded-lg hover:bg-red-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Reset
              </button>
              <button
                onClick={handleDownload}
                className="px-6 py-2 font-semibold text-white bg-purple-500 rounded-lg hover:bg-purple-600 transition duration-300 ease-in-out transform hover:scale-105"
              >
                Download DITA-OT
              </button>
            </div>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <div className="transition-all ease-in-out duration-500">
      {renderSectionContent()}
    </div>
  );
};

export default MainContent;
