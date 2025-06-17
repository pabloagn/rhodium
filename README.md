<p align="center"><img src="assets/logo.png" width=500px></p>

<p align="center">A robust, hypermodular NixOS system</p>

<br/>
<div align="center">───────  ‡  ───────</div>
<br/>

<br/>

<div align ="center">

[![Last Commit](https://img.shields.io/github/last-commit/pabloagn/rhodium?style=for-the-badge&logo=git&logoColor=white&color=7AA89F&labelColor=000000&label=LAST%20COMMIT)](https://github.com/pabloagn/rhodium/commits/main) [![License](https://img.shields.io/github/license/pabloagn/rhodium?style=for-the-badge&color=7AA89F&labelColor=000000)](https://github.com/pabloagn/rhodium/blob/main/LICENSE)

[![Made with Nix](https://img.shields.io/badge/Made%20with-Nix-7AA89F?style=for-the-badge&logo=nixos&logoColor=white&labelColor=000000)](https://nixos.org/)
[![Made with Lua](https://img.shields.io/badge/Made%20with-Lua-7AA89F?style=for-the-badge&logo=lua&logoColor=white&labelColor=000000)](https://www.lua.org/)
[![Made with Rust](https://img.shields.io/badge/Made%20with-Rust-7AA89F?style=for-the-badge&logo=rust&logoColor=white&labelColor=000000)](https://www.rust-lang.org/)

</div>

<br/>

## <samp>⊹ THE TOOLS</samp>

<pre>
• Window Manager ...................... <a href="https://github.com/YaLTeR/niri/">Niri</a>
• Shells .............................. <a href="https://www.nushell.sh/">Nu</a> | <a href="https://fishshell.com/">Fish</a>
• Prompt .............................. <a href="https://github.com/starship/starship">Starship</a>
• Terminals ........................... <a href="https://ghostty.org/">Ghostty</a> | <a href="https://sw.kovidgoyal.net/kitty/">Kitty</a>
• Notify Daemon ....................... <a href="https://github.com/emersion/mako">Mako</a>
• Launcher ............................ <a href="https://codeberg.org/dnkl/fuzzel">Fuzzel</a>
• File Manager ........................ <a href="https://github.com/sxyazi/yazi">Yazi</a>
• IDEs ................................ <a href="https://neovim.io/doc/">NeoVim</a> | <a href="https://docs.helix-editor.com/">Helix</a> | <a href="https://docs.doomemacs.org/latest/">Doom Emacs</a> | <a href="https://zed.dev/">Zed Editor</a>
• LockScreen .......................... <a href="https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/">Hyprlock</a>
• ColorScheme ......................... <a href="https://github.com/webhooked/kanso.nvim">Kansō</a>
</pre>

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

