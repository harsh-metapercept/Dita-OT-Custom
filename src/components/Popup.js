import React from "react";
import { FaCheckCircle, FaTimesCircle } from "react-icons/fa";

const Popup = ({ message, status }) => {
  return (
    <div
      className={`fixed top-20 right-10 p-4 rounded-lg shadow-lg transition-all duration-300 ${
        status === "success"
          ? "bg-green-100 text-green-800"
          : "bg-red-100 text-red-800"
      }`}
    >
      <div className="flex items-center">
        {status === "success" ? (
          <FaCheckCircle className="mr-2" />
        ) : (
          <FaTimesCircle className="mr-2" />
        )}
        <span>{message}</span>
      </div>
    </div>
  );
};

export default Popup;
