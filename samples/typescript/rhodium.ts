// rhodium.ts
// This is a test for TypeScript linters and language servers.

interface User {
    id: number;
    name: string;
    isActive: boolean;
}

const greeting: string = "Welcome to Rhodium";
const user: User = {
    id: 1,
    name: "Tester",
    isActive: true
};

function displayGreeting(message: string, userName: string): void {
    console.log(`${message}, ${userName}!`);
}

displayGreeting(greeting, user.name);
