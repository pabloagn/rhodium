---
layout: default
title: Home
nav_order: 1
description: "A hypermodular NixOS system built to stand the test of time"
permalink: /
---

## Quick Navigation

- [**About**]({{ '/about' | relative_url }}) - Learn about Rhodium's philosophy and goals
- [**Tools**]({{ '/tools' | relative_url }}) - Explore the comprehensive toolset
- [**Features**]({{ '/features' | relative_url }}) - Discover advanced capabilities
- [**Quick Start**]({{ '/quick-start' | relative_url }}) - Get up and running immediately

## Get Started

```bash
git clone https://github.com/pabloagn/rhodium
sudo nixos-rebuild build --flake .#your-hostname
sudo nixos-rebuild switch --flake .#your-hostname
```
