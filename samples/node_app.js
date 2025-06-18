// node_app.js
// This is a test for Node.js specific features and linters.

const os = require('os'); // Example of Node.js built-in module

const welcomeMessage = "Welcome to Rhodium";
const userInfo = os.userInfo();

console.log(`${welcomeMessage}, ${userInfo.username}!`);
console.log(`Running on Node.js ${process.version} on ${os.platform()}.`);
