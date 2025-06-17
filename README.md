<p align="center"><img src="assets/logo.png" width=500px></p>

<div align="center">

![Last Commit](https://img.shields.io/github/last-commit/pabloagn/rhodium?style=for-the-badge&logo=git&logoColor=white&color=7AA89F&labelColor=000000&label=LAST%20COMMIT)
•
[![License](https://img.shields.io/github/license/pabloagn/rhodium?style=for-the-badge&color=7AA89F&labelColor=000000)](https://github.com/pabloagn/rhodium/blob/main/LICENSE)

<p align="center">
 <a href="https://nixos.org/"><img src="https://img.shields.io/badge/Made%20with-Nix-7AA89F?style=for-the-badge&logo=nixos&logoColor=white&labelColor=000000" alt="Made with Nix"></a>
 •
 <a href="https://www.lua.org/"><img src="https://img.shields.io/badge/Made%20with-Lua-7AA89F?style=for-the-badge&logo=lua&logoColor=white&labelColor=000000" alt="Made with Lua"></a>
 •
 <a href="https://www.rust-lang.org/"><img src="https://img.shields.io/badge/Made%20with-Rust-7AA89F?style=for-the-badge&logo=rust&logoColor=white&labelColor=000000" alt="Made with Rust"></a>
</p>

</div>

<!-- <h3 align="center">Rhodium</h3> -->

<!-- <h1 align="center"> -->
<!--   <img src="https://readme-typing-svg.herokuapp.com/?lines=A+robust,+hypermodular+NixOS+system&font=Fira%20Code&size=28&duration=3000&pause=1000&color=8A2BE2&center=true&width=600&height=50" alt="Typing SVG" /> -->
<!-- </h1> -->

<p align="center">A robust, hypermodular NixOS system</p>

<p align="center">────────────── ‡ ──────────────</p>

- **Window Manager** [Niri](https://github.com/YaLTeR/niri/)  
- **Shells** [Nu](https://www.nushell.sh/) | [Fish](https://www.nushell.sh/)  
- **Prompt** [Starship](https://github.com/starship/starship)  
- **Terminals** [Ghostty](https://ghostty.org/) | [Kitty](https://ghostty.org/)  
- **Notify Daemon** [Mako](https://github.com/emersion/mako)  
- **Launcher** [Fuzzel](https://codeberg.org/dnkl/fuzzel)  
- **File Manager** [Yazi](https://github.com/sxyazi/yazi)  
- **IDEs** [NeoVim](https://neovim.io/doc/) | [Helix](https://docs.helix-editor.com/) | [Doom Emacs](https://docs.doomemacs.org/latest/) | [Zed Editor](https://zed.dev/)  
- **LockScreen** [Hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/)  
- **ColorScheme** [Kansō](https://github.com/webhooked/kanso.nvim)

## <samp>⊹ QUICK START</samp>

After setting up a basic NixOS system, you can create a new derivation using this flake:

```bash
sudo nixos-rebuild switch --flake 'github:pabloagn/rhodium#{hostname}'
```

Where `hostname` is the target host you want to use. Consult [hosts](./hosts) for the full specification.

## <samp>⊹ TESTING</samp>

- You can clone this repository and test before committing to a full derivation:

```bash
# Using https
git clone https://github.com/pabloagn/rhodium

# Using SSH
git clone git@github.com:pabloagn/rhodium
```

- Start with `nixos-rebuild build`:

```bash
sudo nixos-rebuild build --flake .#your-hostname
```

This quickly checks if your configuration builds successfully without applying changes. It's fast and catches syntax errors and missing packages.

- When build succeeds, use `nixos-rebuild test`:

```bash
sudo nixos-rebuild test --flake .#your-hostname
```

This creates a temporary boot entry with your changes. If something breaks, simply reboot to return to your stable system. The temporary entry is automatically removed after a successful reboot.

### <samp>⊹ BUILDING</samp>

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

This makes the changes permanent, with the ability to roll back from GRUB if needed.

## <samp>⊹ FEATURES</samp>

## <samp>⊹ USAGE</samp>

## <samp>⊹ OPTIONS</samp>

## <samp>⊹ KEYBINDS</samp>

## <samp>⊹ SHOWCASE</samp>

## <samp>⊹ ATTRIBUTIONS</samp>

- [linuxmobile/kaku](https://github.com/linuxmobile/kaku)
- [internet-development/www-sacred](https://github.com/internet-development/www-sacred)
- [HyDE-Project/HyDE](https://github.com/HyDE-Project/)
- [nyoom-engineering/nyoom.nvim](https://github.com/nyoom-engineering/nyoom.nvim)

