import React from "react";
import logo from "E:/arigo 2/dita-ot-ui/src/logo.png";

const Sidebar = ({ activeSection, handleSidebarNavigation }) => {
  return (
    <div className="w-72 bg-gradient-to-r from-blue-400 to-gray-800 text-white p-6 flex flex-col h-screen fixed top-0 left-0 shadow-xl rounded-none transition-transform transform-gpu ease-in-out duration-500 slide-in-left">
      <div className="mb-10 text-center">
        <img
          src={logo} // Replace with the actual path to your logo image
          alt="DITA-OT Customizer Logo"
          className="w-28 mx-auto"
        />
      </div>
      <ul className="space-y-4">
        {/* Introduction Section */}
        <li
          onClick={() => handleSidebarNavigation(1)}
          className={`cursor-pointer py-3 px-4 rounded-lg hover:bg-white hover:bg-opacity-20 transition-all duration-300 text-lg font-medium transform-gpu ease-in-out ${
            activeSection === 1
              ? "bg-white bg-opacity-30 scale-105"
              : "hover:scale-105"
          }`}
        >
          Introduction
        </li>
        {/* Theme Editor Section */}
        <li
          onClick={() => handleSidebarNavigation(2)}
          className={`cursor-pointer py-3 px-4 rounded-lg hover:bg-white hover:bg-opacity-20 transition-all duration-300 text-lg font-medium transform-gpu ease-in-out ${
            activeSection === 2
              ? "bg-white bg-opacity-30 scale-105"
              : "hover:scale-105"
          }`}
        >
          Theme Editor
        </li>
        {/* Header Section */}
        <li
          onClick={() => handleSidebarNavigation(3)}
          className={`cursor-pointer py-3 px-4 rounded-lg hover:bg-white hover:bg-opacity-20 transition-all duration-300 text-lg font-medium transform-gpu ease-in-out ${
            activeSection === 3
              ? "bg-white bg-opacity-30 scale-105"
              : "hover:scale-105"
          }`}
        >
          Header
        </li>
        {/* Footer Section */}
        <li
          onClick={() => handleSidebarNavigation(4)}
          className={`cursor-pointer py-3 px-4 rounded-lg hover:bg-white hover:bg-opacity-20 transition-all duration-300 text-lg font-medium transform-gpu ease-in-out ${
            activeSection === 4
              ? "bg-white bg-opacity-30 scale-105"
              : "hover:scale-105"
          }`}
        >
          Footer
        </li>
        {/* Final Customization Section */}
        <li
          onClick={() => handleSidebarNavigation(5)}
          className={`cursor-pointer py-3 px-4 rounded-lg hover:bg-white hover:bg-opacity-20 transition-all duration-300 text-lg font-medium transform-gpu ease-in-out ${
            activeSection === 5
              ? "bg-white bg-opacity-30 scale-105"
              : "hover:scale-105"
          }`}
        >
          Final Customization
        </li>
      </ul>
    </div>
  );
};

export default Sidebar;
