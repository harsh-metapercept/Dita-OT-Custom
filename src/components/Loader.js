import React from "react";

const Loader = () => {
  return (
    <div className="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
      <div className="spinner-border animate-spin inline-block w-8 h-8 border-4 border-t-indigo-500 border-indigo-200 rounded-full"></div>
    </div>
  );
};

export default Loader;
