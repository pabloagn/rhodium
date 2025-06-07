# Rhodium

A robust, hypermodular NixOS system.

## Usage

### Testing

1. Start with `nixos-rebuild build`:

```bash
sudo nixos-rebuild build --flake .#your-hostname
```

This quickly checks if your configuration builds successfully without applying changes. It's fast and catches syntax errors and missing packages.

2. When build succeeds, use `nixos-rebuild test`:

```bash
sudo nixos-rebuild test --flake .#your-hostname
```

This creates a temporary boot entry with your changes. If something breaks, simply reboot to return to your stable system. The temporary entry is automatically removed after a successful reboot.

### Building

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

This makes the changes permanent, with the ability to roll back from GRUB if needed.

## Architecture

### Flake Inputs

Rhodium uses several flake inputs additional to NixOS builtins:

- A
- B
- C

### Flake Outputs

- A
- B
- C

### Module Options Generators

- A
- B
- C

## Modules

### Hyprland

When setting up monitors and using custom scaling, ensure the following:

```text
Scale 1.6: 3840/1.6 = 2400, 2160/1.6 = 1350 OK
Scale 1.8: 3840/1.8 = 2133.33... WRONG (decimals)
Scale 2.0: 3840/2.0 = 1920, 2160/2.0 = 1080 OK
Scale 2.4: 3840/2.4 = 1600, 2160/2.4 = 900 OK
Scale 3.0: 3840/3.0 = 1280, 2160/3.0 = 720 OK 
```

## Tips

- A
- B
- C

### Evaluating Expressions

```bash
nix repl
```

```nix
myVar = "hello"
```
