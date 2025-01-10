import React from "react";

const HeaderFooterCustomization = ({
  companyName,
  setCompanyName,
  companyWebsite,
  setCompanyWebsite,
  handleNextSection,
  handlePreviousSection,
}) => (
  <div className="bg-white p-6 rounded-lg shadow-lg max-w-lg mx-auto">
    <h2 className="text-2xl font-semibold mb-6 text-center">
      🖼️ Footer and Header Customization
    </h2>
    <div className="mb-6">
      <label className="block font-semibold mb-2">Company Name:</label>
      <input
        type="text"
        value={companyName}
        onChange={(e) => setCompanyName(e.target.value)}
        className="w-full px-3 py-2 border rounded"
      />
    </div>
    <div className="mb-6">
      <label className="block font-semibold mb-2">Company Website:</label>
      <input
        type="url"
        value={companyWebsite}
        onChange={(e) => setCompanyWebsite(e.target.value)}
        className="w-full px-3 py-2 border rounded"
      />
    </div>
    <div className="flex gap-4">
      <button onClick={handlePreviousSection} className="bg-gray-500 text-white px-4 py-2 rounded">
        Previous
      </button>
      <button onClick={handleNextSection} className="bg-blue-500 text-white px-4 py-2 rounded">
        Next
      </button>
    </div>
  </div>
);

export default HeaderFooterCustomization;
