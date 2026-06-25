import React, { useEffect, useState } from 'react';

function App() {
  const [backendData, setBackendData] = useState(null);

  useEffect(() => {
    // Fetch data from the backend API
    fetch('/api/data')
      .then(response => response.json())
      .then(data => setBackendData(data))
      .catch(err => console.error("Error fetching data:", err));
  }, []);

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      <h1>welcome to the e-commerce store</h1>
      {backendData ? (
        <div>
          <p>Current Data Source: <strong>{backendData.source}</strong></p>
          {/* Here we display the products if they are returned from the backend */}
          <pre>{JSON.stringify(backendData.data, null, 2)}</pre>
        </div>
      ) : (
        <p>Loading data from the API...</p>
      )}
    </div>
  );
}

export default App;