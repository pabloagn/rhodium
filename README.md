# Rhodium

A robust NixOS system.

## Exploring The System

## Testing Framework

1. Start with `nixos-rebuild build`:

  ```bash
  nixos-rebuild build --flake .#your-hostname
  ```

This quickly checks if your configuration builds successfully without applying changes. It's fast and catches syntax errors and missing packages.

2. When build succeeds, use `nixos-rebuild test`:

  ```bash
  nixos-rebuild test --flake .#your-hostname
  ```

This creates a temporary boot entry with your changes. If something breaks, simply reboot to return to your stable system. The temporary entry is automatically removed after a successful reboot.

## Building The System

```bash
nixos-rebuild switch --flake .#your-hostname
```

This makes the changes permanent, with the ability to roll back from GRUB if needed.

## Flake Inputs

Rhodium uses several flake inputs additional to NixOS builtins:

- A
- B
- C

## Nix

### Evaluating Expressions

```bash
nix repl
```

```nix
myVar = "hello"
```
