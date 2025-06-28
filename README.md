<p align="center"><img src="assets/logo.png" width=500px></p>

<p align="center"><em>A hypermodular NixOS system built to stand the test of time</em></p>

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

## <samp>⊹ ABOUT</samp>

Rhodium is a declarative NixOS system preconfigured with sensible defaults, aimed towards academics & professionals looking for stability without sacrificing innovation.

This hypermodular configuration combines the declarative power of Nix with 150+ curated packages using a profile-based configuration.

<br/>
<div align="center">
    <div id="images">
        <p style="text-align:center;">
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Robust-f2f2f2?style=for-the-badge"/></a>&nbsp&nbsp
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Fast-f2f2f2?style=for-the-badge"/></a>&nbsp&nbsp
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Elegant-f2f2f2?style=for-the-badge"/></a>&nbsp&nbsp
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Reliable-f2f2f2?style=for-the-badge"/></a>&nbsp&nbsp
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Reproducible-f2f2f2?style=for-the-badge"/></a>&nbsp&nbsp
        <a href="https://github.com/pabloagn/rhodium#-features-1">
        <img src="https://img.shields.io/badge/Secure-f2f2f2?style=for-the-badge"/></a>
    </div>
</div>
<br/>

## <samp>⊹ MOTIVATION</samp>

It's difficult to find Linux rices aimed towards professional workflows. NixOS brings that opportunity closer than ever by providing the required framework to build setups that not only look pretty, but work pretty, but alas, that is not enough.

Rhodium emerges in order to fill that gap:

<br/>
<p align="center"><em>To provide a robust & reliable Linux configuration specifically tailored for high-performance research & development environments</em></p>
<br/>

## <samp>⊹ TOOLS</samp>

### <samp>◇ MAIN</samp>

<pre>
• Window Managers ..................... <a href="https://github.com/YaLTeR/niri/">Niri</a> | <a href="https://hypr.land/">Hyprland</a>
├─ Mnemonic keybinding system (200+ binds)
├─ Dynamic & static workspace management capabilities by default
├─ Preconfigured [XWayland-satellite](https://github.com/Supreeeme/xwayland-satellite)
├─ Preconfigured Niri IPC aliases for full runtime control
└─ Multi-monitor support with wlr-randr/wl-mirror

• Bars & Widgets ...................... <a href="https://github.com/Alexays/Waybar">Waybar</a> | <a href="https://github.com/elkowar/eww">Eww</a>
├─ Modular widget architecture
├─ Custom styling with CSS/SCSS support
├─ Real-time system monitoring & metrics
├─ Custom tooltips, alternative modes & actions for each module
├─ Native integration with Niri (preconfigured Niri modules)
└─ Workspace & window state integration

• Shells .............................. <a href="https://www.nushell.sh/">Nu</a> | <a href="https://fishshell.com/">Fish</a> | <a href="https://www.zsh.org/">Zsh</a>
├─ 15+ sensible function binds
└─ 70+ sensible aliases

• Prompt .............................. <a href="https://github.com/starship/starship">Starship</a>
• Terminals ........................... <a href="https://ghostty.org/">Ghostty</a> | <a href="https://sw.kovidgoyal.net/kitty/">Kitty</a>
• Multiplexers ........................ <a href="https://zellij.dev/">Zellij</a> | <a href="https://github.com/tmux/tmux/">Tmux</a>
└─ Predefined profile-based templates

• Notification Daemon ................. <a href="https://github.com/emersion/mako">Mako</a>
├─ Custom notification groups & categories
├─ Full Unicode character compatibility
├─ Context-aware styling & positioning
├─ Systemd integration for lifecycle management
└─ Quirky easter eggs

• Launcher ............................ <a href="https://codeberg.org/dnkl/fuzzel">Fuzzel</a>
├─ Mnemonic keybinding system
├─ <a href="https://github.com/rhodium/home/scripts/fuzzel">28 customizable menus</a> & counting
└─ Interactive selections, submenu integration, cached content

• File Manager ........................ <a href="https://github.com/sxyazi/yazi">Yazi</a>
├─ Mnemonic keybinding system
├─ Specialized MIMEs & openers
└─ Smart preloaders & prefetchers

• IDEs ................................ <a href="https://neovim.io/doc/">NeoVim</a> | <a href="https://docs.helix-editor.com/">Evil-Helix</a> | <a href="https://docs.doomemacs.org/latest/">Doom Emacs</a> | <a href="https://zed.dev/">Zed Editor</a>
├─ Mnemonic keybinding system (300+ registries)
├─ 50+ LSP servers with dual Nix LSP support
├─ 40+ carefully curated, batteries-included plugins loved by the community
├─ Custom Lua function library & ftplugins
└─ GitHub workflow integration

• LockScreen .......................... <a href="https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/">Hyprlock</a>
├─ Easy ASCII art injection
└─ Custom-themed

• ColorScheme ......................... <a href="https://github.com/webhooked/kanso.nvim">Kansō</a>
└─ 10+ custom ports
</pre>

### <samp>◇ OTHERS</samp>


## <samp>⊹ FEATURES</samp>

### <samp>◇ MAIN</samp>

<pre>
• Development Environments ............ Preconfigured Flakes for 10+ Languages
├─ Rust, Python, JavaScript/TypeScript, Go, C/C++, Java environments
├─ Nix shells with automatic environment loading & direnv integration
├─ Language-specific toolchains, formatters & linters
└─ IDE integration with 50+ LSP servers & debugging support

• Nix Infrastructure .................. Flake Parts & Advanced Architecture
├─ Flake-parts modular system with per-system configurations
├─ Custom package overlays for bleeding-edge & patched software
├─ Advanced flake input management with lock file automation
├─ Home Manager & NixOS custom modules with option validation
└─ Cross-platform support (NixOS/Darwin/Standalone Home Manager)

• Hardware & System Integration ....... Automatic Hardware Detection
├─ Automatic hardware configuration generation & optimization
├─ GPU driver management (NVIDIA/AMD) with compute acceleration
├─ Power management profiles for laptops & desktops
├─ Audio pipewire configuration with low-latency optimization
└─ Network configuration with VPN & wireless management

• Secrets & Security Management ....... SOPS-Nix Integration
├─ Age-encrypted secrets with automatic key rotation
├─ Per-host secret deployment with secure key distribution
├─ Git-tracked encrypted configuration files
└─ Runtime secret injection into services & applications

• CI/CD & Deployment .................. GitHub Actions & NixOS Anywhere
├─ Automated flake validation & security scanning
├─ Remote deployment with nixos-anywhere integration
├─ Multi-architecture builds (x86_64, aarch64) in CI
├─ Automatic dependency updates with compatibility testing
└─ Infrastructure as Code with declarative host provisioning

• Automation & Orchestration ......... Systemd Services & Cron Jobs
├─ User services for desktop components (bars, notifications, wallpapers)
├─ System services for monitoring, backups & maintenance
├─ Automated garbage collection with storage optimization
├─ Service dependency management with health monitoring
└─ Scheduled tasks for system maintenance & updates

• Configuration Management ............ Atomic Operations & Rollbacks
├─ Declarative configuration with full reproducibility
├─ Atomic system updates with automatic rollback capabilities
├─ Generation management with selective cleanup
├─ Configuration validation before deployment
└─ Modular architecture for component isolation & testing

• Development Tooling ................. Advanced Development Features
├─ Pre-commit hooks with formatting & linting automation
├─ Development containers with isolated environments
├─ Custom build scripts & deployment workflows
├─ Documentation generation with automatic API references
└─ Testing frameworks with CI integration
</pre>

### <samp>◇ OTHERS</samp>


## <samp>⊹ QUICK START</samp>

There are two main ways to interact with Rhodium:
- Using the built-in [justfile](./justfile).
- Using nix flake commands directly.

### <samp>⊹ JUST</samp>

<br/>
<p align="center"><em>∿ Just switch and let everything flow ∿</em></p>
<br/>

This system includes a comprehensive [justfile](https://github.com/casey/just) at the flake root for system management. After cloning the repository, you can use these commands:

```bash
# Show all available commands
just

# Build and switch to new configuration
just switch

# Build configuration for specific host
just switch hostname

# Test build without switching
just build

# Fast rebuild with minimal output
just fast

# Update all flake inputs
just update

# Clean old generations (keep 5 most recent)
just gc-keep

# Check system health
just health

# Format all Nix files
just fmt

# Rollback to previous generation
just rollback
```

### <samp>⊹ MANUAL</samp>

You can directly run the typical nix flake commands directly instead of relying on the justfile. After setting up a basic NixOS system, you can create a new derivation using this flake:

```bash
sudo nixos-rebuild switch --flake 'github:pabloagn/rhodium#{hostname}'
```

Where `hostname` is the target host you want to use. Consult [hosts](./hosts) for the full specification.

Alternatively, you can clone this repository and test before committing to a full derivation:

```bash
# Using https
git clone https://github.com/pabloagn/rhodium

# Using SSH
git clone git@github.com:pabloagn/rhodium
```

Start with `nixos-rebuild build`:

```bash
sudo nixos-rebuild build --flake .#your-hostname
```

This quickly checks if your configuration builds successfully without applying changes. It's fast and catches syntax errors and missing packages.

When build succeeds, use `nixos-rebuild test`:

```bash
sudo nixos-rebuild test --flake .#your-hostname
```

This creates a temporary boot entry with your changes. If something breaks, simply reboot to return to your stable system. The temporary entry is automatically removed after a successful reboot.

Whenever you're ready, build the new derivation and switch:

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

