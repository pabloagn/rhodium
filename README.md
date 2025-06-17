<p align="center"><img src="assets/logo.png" width=300px></p>

<h2 align="center">Rhodium</h2>

A robust, hypermodular NixOS system.

---

- **Window Manager**
    - [Niri](https://github.com/YaLTeR/niri/)
- **Shells**
    - [Nu](https://www.nushell.sh/)
    - [Fish](https://www.nushell.sh/)
- Prompt
    - [Starship](https://github.com/starship/starship)
- **Terminals**
    - [Ghostty](https://ghostty.org/)
    - [Kitty](https://ghostty.org/)
- **Notify Daemon**
    - [Mako](https://github.com/emersion/mako)
- **Launcher**
    - [Fuzzel](https://codeberg.org/dnkl/fuzzel)
- **File Manager**
    - [Yazi](https://github.com/sxyazi/yazi)
- **IDEs**
    - [NeoVim](https://neovim.io/doc/)
    - [Helix](https://docs.helix-editor.com/)
    - [Doom Emacs](https://docs.doomemacs.org/latest/)
    - [Zed Editor](https://zed.dev/)
- **LockScreen**
    - [Hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/)
- **ColorScheme**
    - [Kansō](https://github.com/webhooked/kanso.nvim)


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

### Dunst

Test notifications from command line:

```bash
# Basic notifications
notify-send "Test" "Basic notification"
notify-send "Sacred Computer" "Terminal aesthetic engaged"

# Urgency levels
notify-send -u low "Low Priority" "Subdued notification"
notify-send -u normal "Normal Priority" "Standard notification" 
notify-send -u critical "Critical Alert" "Stays until dismissed"

# Application-specific tests
notify-send "System Test" "Tests system styling"
notify-send "Volume" "75%"
notify-send "Brightness" "50%"

# Progress bar test
notify-send "Progress" "Loading..." -h int:value:42

# Long text test
notify-send "Long Message" "This is a much longer notification message to test how word wrapping and text formatting works with your new dunst configuration."

# Multiple notifications (stacking test)
notify-send "First" "Message 1"
notify-send "Second" "Message 2" 
notify-send "Third" "Message 3"
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

