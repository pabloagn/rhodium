// App.jsx
import React from "react"; // This is a test for React JSX and language servers.
import "./style.css"; // Assuming you have a style.css for basic styling

function App() {
  const greeting = "Welcome to Rhodium";

  return (
    <div className="app-container">
      <h1 className="welcome-message">{greeting}</h1>
      <p>This is a simple React component for testing your environment.</p>
      {/* A simple comment in JSX */}
    </div>
  );
}

export default App;
