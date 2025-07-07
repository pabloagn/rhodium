---
layout: default
title: Home
---

<div class="hero">
    <img src="{{ '/assets/logo.png' | relative_url }}" alt="Rhodium Logo" class="hero-logo">
    <p class="hero-subtitle">A hypermodular NixOS system built to stand the test of time</p>
    
    <div class="hero-divider">───────  ‡  ───────</div>
    
    <div class="hero-badges">
        <a href="https://github.com/pabloagn/rhodium/commits/main">
            <img src="https://img.shields.io/github/last-commit/pabloagn/rhodium?style=for-the-badge&logo=git&logoColor=white&color=7AA89F&labelColor=000000&label=LAST%20COMMIT" alt="Last Commit">
        </a>
        <a href="https://github.com/pabloagn/rhodium/blob/main/LICENSE">
            <img src="https://img.shields.io/github/license/pabloagn/rhodium?style=for-the-badge&color=7AA89F&labelColor=000000" alt="License">
        </a>
    </div>
    
    <div class="hero-badges">
        <a href="https://nixos.org/">
            <img src="https://img.shields.io/badge/Made%20with-Nix-7AA89F?style=for-the-badge&logo=nixos&logoColor=white&labelColor=000000" alt="Made with Nix">
        </a>
        <a href="https://www.lua.org/">
            <img src="https://img.shields.io/badge/Made%20with-Lua-7AA89F?style=for-the-badge&logo=lua&logoColor=white&labelColor=000000" alt="Made with Lua">
        </a>
        <a href="https://www.rust-lang.org/">
            <img src="https://img.shields.io/badge/Made%20with-Rust-7AA89F?style=for-the-badge&logo=rust&logoColor=white&labelColor=000000" alt="Made with Rust">
        </a>
    </div>
</div>

## Quick Navigation

- [**About**]({{ '/01-about' | relative_url }}) - Learn about Rhodium's philosophy and goals
- [**Tools**]({{ '/03-tools' | relative_url }}) - Explore the comprehensive toolset
- [**Features**]({{ '/04-features' | relative_url }}) - Discover advanced capabilities
- [**Quick Start**]({{ '/05-quick-start' | relative_url }}) - Get up and running immediately

## Get Started

```bash
git clone https://github.com/pabloagn/rhodium
sudo nixos-rebuild build --flake .#your-hostname
sudo nixos-rebuild switch --flake .#your-hostname
