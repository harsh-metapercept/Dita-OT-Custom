import React from "react";

const FinalCustomization = ({
  handleApplyChanges,
  handleUpdateFooter,
  handleDownload,
  handleReset,
  isLoading,
}) => (
  <div className="text-center">
    <h2 className="text-2xl font-semibold mb-4">⚙️ Final Customization</h2>
    <div className="flex gap-4 justify-center">
      <button onClick={handleApplyChanges} disabled={isLoading} className="bg-blue-500 text-white px-4 py-2 rounded">
        {isLoading ? "Applying..." : "Apply Changes"}
      </button>
      <button onClick={handleUpdateFooter} className="bg-green-500 text-white px-4 py-2 rounded">
        Update Footer
      </button>
      <button onClick={handleReset} className="bg-red-500 text-white px-4 py-2 rounded">
        Reset
      </button>
      <button onClick={handleDownload} className="bg-purple-500 text-white px-4 py-2 rounded">
        Download DITA-OT
      </button>
    </div>
  </div>
);

export default FinalCustomization;
