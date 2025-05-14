# Home Manager Roles

Roles define what a user CAN do (permissions, capabilities, access rights).

Each role file (admin.nix, developer.nix, etc.) contains:

- Permission settings
- Environment variables
- Shell aliases related to the role's responsibilities
- Any configuration that grants specific capabilities

Roles are MINIMAL and focused on enabling functionality, not providing software.
