---
layout: default
title: Home
nav_order: 1
description: "A hypermodular NixOS system built to stand the test of time"
permalink: /
---

<div class="hero">
    <img src="{{ '/assets/logo.png' | relative_url }}" alt="Rhodium Logo" class="hero-logo">
    <p class="hero-subtitle">A hypermodular NixOS system built to stand the test of time</p>
    
    <div class="hero-divider">───────  ‡  ───────</div>
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
```
