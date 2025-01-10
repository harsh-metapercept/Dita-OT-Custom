import React, { useState, useEffect } from "react";
import axios from "axios";
import Sidebar from "./Sidebar";
import MainContent from "./MainContent";
import { FaCheckCircle, FaTimesCircle } from "react-icons/fa";

const App = () => {
  // State variables
  const [primaryColor, setPrimaryColor] = useState("#ffffff");
  const [logoFile, setLogoFile] = useState(null);
  const [companyName, setCompanyName] = useState("");
  const [companyWebsite, setCompanyWebsite] = useState("");
  const [uploadMessage, setUploadMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [activeSection, setActiveSection] = useState(1);
  const [popUpStatus, setPopUpStatus] = useState(null);

  const API_BASE_URL =
    process.env.REACT_APP_API_BASE_URL || "http://localhost:5000";

  // Effect for auto-dismiss popup
  useEffect(() => {
    if (popUpStatus) {
      const timer = setTimeout(() => {
        setPopUpStatus(null);
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [popUpStatus]);

  // Handle applying changes
  const handleApplyChanges = async () => {
    if (!primaryColor || !logoFile) {
      setUploadMessage("Please select a primary color and upload a logo file.");
      setPopUpStatus("error");
      return;
    }

    const formData = new FormData();
    formData.append("headerColor", primaryColor);
    formData.append("logo", logoFile);

    setIsLoading(true);
    setUploadMessage("");

    try {
      const response = await axios.post(`${API_BASE_URL}/upload`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      setUploadMessage("Changes applied successfully!");
      setPopUpStatus("success");
      console.log("Response:", response.data);
    } catch (error) {
      setUploadMessage(
        error.response?.data?.message ||
          "An error occurred while applying changes."
      );
      setPopUpStatus("error");
      console.error("Error uploading:", error.message);
    } finally {
      setIsLoading(false);
    }
  };

  // Handle footer updates
  const handleUpdateFooter = async () => {
    if (!companyName.trim() || !companyWebsite.trim()) {
      setUploadMessage("Company name and website cannot be empty.");
      setPopUpStatus("error");
      return;
    }

    try {
      const response = await axios.post(`${API_BASE_URL}/update-footer`, {
        companyName,
        companyWebsite,
      });
      setUploadMessage("Footer updated successfully!");
      setPopUpStatus("success");
      console.log("Response:", response.data);
    } catch (error) {
      setUploadMessage(
        error.response?.data?.message ||
          "An error occurred while updating the footer."
      );
      setPopUpStatus("error");
      console.error("Error updating footer:", error.message);
    }
  };

  // Handle download of updated DITA-OT
  const handleDownload = async () => {
    try {
      const response = await axios.get(`${API_BASE_URL}/download`, {
        responseType: "blob",
      });
      const link = document.createElement("a");
      link.href = URL.createObjectURL(response.data);
      link.download = "updated-dita-ot.zip";
      link.click();
    } catch (error) {
      console.error("Error downloading:", error.message);
      setUploadMessage("An error occurred while downloading.");
      setPopUpStatus("error");
    }
  };

  // Handle navigation
  const handleNextSection = () => {
    setActiveSection((prevSection) => Math.min(prevSection + 1, 5));
  };

  const handlePreviousSection = () => {
    setActiveSection((prevSection) => Math.max(prevSection - 1, 1));
  };

  // Reset form fields
  const handleReset = () => {
    setPrimaryColor("#ffffff");
    setLogoFile(null);
    setCompanyName("");
    setCompanyWebsite("");
    setUploadMessage("");
    setPopUpStatus(null);
    setActiveSection(1);
  };

  // Sidebar navigation
  const handleSidebarNavigation = (section) => {
    setActiveSection(section);
  };

  return (
    <div className="min-h-screen flex">
      <Sidebar
        activeSection={activeSection}
        handleSidebarNavigation={handleSidebarNavigation}
      />
      <div className="flex-1 p-6">
        <MainContent
          activeSection={activeSection}
          setActiveSection={setActiveSection}
          primaryColor={primaryColor}
          setPrimaryColor={setPrimaryColor}
          logoFile={logoFile}
          setLogoFile={setLogoFile}
          companyName={companyName}
          setCompanyName={setCompanyName}
          companyWebsite={companyWebsite}
          setCompanyWebsite={setCompanyWebsite}
          handleApplyChanges={handleApplyChanges}
          handleUpdateFooter={handleUpdateFooter}
          handleDownload={handleDownload}
          handleReset={handleReset}
          uploadMessage={uploadMessage}
          isLoading={isLoading}
          handleNextSection={handleNextSection}
          handlePreviousSection={handlePreviousSection}
        />

        {/* Loading spinner */}
        {isLoading && (
          <div className="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
            <div className="spinner-border animate-spin inline-block w-8 h-8 border-4 border-t-indigo-500 border-indigo-200 rounded-full"></div>
          </div>
        )}

        {/* Popup notifications */}
        {popUpStatus && (
          <div
            className={`fixed top-20 right-10 p-4 rounded-lg shadow-lg transition-all duration-300 ${
              popUpStatus === "success" ? "bg-green-500" : "bg-red-500"
            } text-white`}
          >
            <div className="flex items-center">
              {popUpStatus === "success" ? (
                <FaCheckCircle className="mr-2 text-2xl" />
              ) : (
                <FaTimesCircle className="mr-2 text-2xl" />
              )}
              <span>{uploadMessage}</span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default App;
