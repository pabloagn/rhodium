// script.js
// This is a test for Vanilla JavaScript linters and language servers.

const message = "Welcome to Rhodium";

function displayMessage() {
    console.log(message);
    const appDiv = document.getElementById('app');
    if (appDiv) {
        const p = document.createElement('p');
        p.textContent = message + " (from JS)";
        appDiv.appendChild(p);
    }
}

// Execute when the DOM is fully loaded for browser environments
document.addEventListener('DOMContentLoaded', displayMessage);

// For Node.js environments (won't affect browser, no document here)
if (typeof process !== 'undefined' && process.versions != null && process.versions.node != null) {
    displayMessage();
}
