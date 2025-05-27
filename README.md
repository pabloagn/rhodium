# Rhodium

A robust NixOS system.

## Usage

### Testing

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

### Building

```bash
nixos-rebuild switch --flake .#your-hostname
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

Generators are defined in [`lib/options/optionsGenerators.nix`](lib/options/optionsGenerators.nix).

There are three primary types of module structure generators:

- `mkBasicModule`
- `mkPackageListModule`
- `mkAppModule`

#### `mkBasicModule`

For modules that only need a master `enable` switch. Sub-modules (children in the directory structure) are expected to be loaded by Haumea and will respect this parent `enable` switch via their own `mkChildConfig` usage.

**Example:** [`home/apps/default.nix`](home/apps/default.nix)

This module groups all apps; its sub-categories like `browsers`, `communication` are found and loaded by Haumea.

```nix
# home/apps/default.nix
{ _haumea, rhodiumLib, lib, ... }:

rhodiumLib.mkBasicModule {
  haumea = _haumea;
  inherit lib;
  description = "Rhodium's home applications and utilities";
  defaultEnable = true;
  descriptionSuffix = "suite";
}
```

**Example:** [`home/apps/communication/default.nix`](home/apps/communication/default.nix)

This module groups communication sub-categories like email, messaging, etc., which are separate Haumea-loaded modules.

```nix
# home/apps/communication/default.nix
{ _haumea, rhodiumLib, lib, ... }:

rhodiumLib.mkBasicModule {
  haumea = _haumea;
  inherit lib;
}
```

#### `mkPackageListModule`

For "category" modules that manage a list of simple, individually toggleable packages. Each item in the list gets an enable option.

**Example:** [`home/apps/communication/messaging/default.nix`](home/apps/communication/messaging/default.nix)

Manages a list of messaging applications like Signal, WhatsApp, etc.

```nix
# home/apps/communication/messaging/default.nix
{ _haumea, pkgs, config, lib, rhodiumLib, ... }:

let
  packageSpecs = [
    { name = "signal"; pkg = pkgs.signal-desktop; description = "Signal Desktop private messenger"; }
    { name = "whatsapp"; pkg = pkgs.whatsapp-for-linux; description = "WhatsApp Desktop client"; }
    { name = "telegram"; pkg = pkgs.telegram-desktop; description = "Telegram Desktop messenger"; }
  ];
in
rhodiumLib.mkPackageListModule {
  haumea = _haumea;
  inherit packageSpecs pkgs config lib;
}
```

#### `mkAppModule`

For "leaf" modules that configure a single, potentially complex application. It provides a standard enable option for the app, desktop file customization options, and can handle internal "sub-items" or "variants" (like different versions of an app), or custom options.

**Example (Simple Leaf App):** [`home/apps/terminal/emulators/foot.nix`](home/apps/terminal/emulators/foot.nix)

```nix
# home/apps/terminal/emulators/foot.nix
{ _haumea, pkgs, config, lib, rhodiumLib, ... }:

rhodiumLib.mkAppModule {
  haumea = _haumea;
  inherit pkgs config lib;
  appName = "Foot";
  appDescription = "A fast, lightweight Wayland terminal emulator";
  hasDesktop = true;
  mainPackage = pkgs.foot;
  extraConfig = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=10";
          term = "foot";
        };
        colors = {
          alpha = 0.9;
        };
      };
    };
  };
}
```

**Example (App with Variants/Sub-Items):** [`home/apps/browsers/firefox.nix`](home/apps/browsers/firefox.nix)

Manages different installable variants of Firefox (Stable, Developer Edition, Nightly, etc.).

```nix
# home/apps/browsers/firefox.nix
{ _haumea, pkgs, pkgs-unstable, config, lib, rhodiumLib, ... }:

let
  firefoxSubItemSpecs = [
    {
      name = "stable";
      pkg = pkgs.firefox;
      description = "Firefox Stable: Standard release from 'pkgs'.";
      defaultEnable = false;
    }
    {
      name = "stable-unwrapped";
      pkg = pkgs.firefox-unwrapped;
      description = "Firefox Stable Unwrapped: Unwrapped release from 'pkgs'.";
      defaultEnable = false;
    }
    {
      name = "devedition";
      pkg = pkgs-unstable.firefox-devedition;
      description = "Firefox Developer Edition: From 'pkgs-unstable'.";
      defaultEnable = false;
    }
    {
      name = "devedition-unwrapped";
      pkg = pkgs-unstable.firefox-devedition-unwrapped;
      description = "Firefox Developer Edition Unwrapped: From 'pkgs-unstable'.";
      defaultEnable = false;
    }
    {
      name = "nightly";
      pkg = pkgs-unstable.firefox-nightly;
      description = "Firefox Nightly: Bleeding edge builds from 'pkgs-unstable'.";
      defaultEnable = false;
    }
    {
      name = "esr";
      pkg = pkgs.firefox-esr;
      description = "Firefox ESR: Extended Support Release from 'pkgs'.";
      defaultEnable = false;
    }
    {
      name = "beta";
      pkg = pkgs.firefox-beta;
      description = "Firefox Beta: Beta builds from 'pkgs'.";
      defaultEnable = false;
    }
    {
      name = "beta-unwrapped";
      pkg = pkgs.firefox-beta-unwrapped;
      description = "Firefox Beta Unwrapped: Unwrapped beta builds from 'pkgs'.";
      defaultEnable = false;
    }
  ];
in
rhodiumLib.mkAppModule {
  haumea = _haumea;
  inherit pkgs config lib;
  appName = "Firefox";
  appDescription = "Mozilla Firefox Web Browser (with multiple variants)";
  hasDesktop = true;
  defaultEnable = false;
  subItemSpecs = firefoxSubItemSpecs;
}
```

**Example (App with Custom Options):** [`home/apps/terminal/emulators/kitty.nix`](home/apps/terminal/emulators/kitty.nix)

```nix
# home/apps/terminal/emulators/kitty.nix
{ _haumea, pkgs, config, lib, rhodiumLib, ... }:

let
  cfg = lib.getAttrFromPath _haumea.configPath config;
  kittyCustomOptions = {
    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Path to Kitty theme file or name of a known theme.";
    };
    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Base font size for Kitty.";
    };
  };
in
rhodiumLib.mkAppModule {
  haumea = _haumea;
  inherit pkgs config lib;
  appName = "Kitty";
  hasDesktop = true;
  customOptions = kittyCustomOptions;
  extraConfig = {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font.size = cfg.fontSize;
      theme = cfg.theme;
    };
  };
}
```

**Example (App with Complex Configuration):** [`home/apps/browsers/zen.nix`](home/apps/browsers/zen.nix)

```nix
# home/apps/browsers/zen.nix
{ _haumea, pkgs, config, lib, rhodiumLib, inputs, ... }:

let
  cfg = lib.getAttrFromPath _haumea.configPath config;

  hasZenBrowser = inputs ? zen-browser;
  system = pkgs.stdenv.hostPlatform.system;

  zenCustomOptions = {
    variant = lib.mkOption {
      type = lib.types.enum [ "specific" "generic" ];
      default = "specific";
      description = ''
        Which variant of Zen Browser to install.
        - "specific": Optimized for newer CPUs and kernels (same as 'default')
        - "generic": Maximizes compatibility with old CPUs and kernels
      '';
      example = "generic";
    };
  };

  zenPackages =
    let
      hasPkgsForSystem = hasZenBrowser && inputs.zen-browser.packages ? ${system};
      zenPackage =
        if !hasPkgsForSystem then null
        else if cfg.variant == "specific" then inputs.zen-browser.packages.${system}.specific
        else if cfg.variant == "generic" then inputs.zen-browser.packages.${system}.generic
        else inputs.zen-browser.packages.${system}.default;
    in
    lib.optional (zenPackage != null && hasZenBrowser) zenPackage;

  zenWarnings = lib.optional (hasZenBrowser && !(inputs.zen-browser.packages ? ${system}))
    "Zen browser packages not available for system ${system}";
in
rhodiumLib.mkAppModule {
  haumea = _haumea;
  inherit pkgs config lib;
  appName = "Zen Browser";
  appDescription = "A Firefox-based browser with privacy focus and customization";
  hasDesktop = true;
  defaultEnable = false;
  customOptions = zenCustomOptions;
  extraConfig = {
    home.packages = zenPackages;
    warnings = zenWarnings;
  };
}
```

## Tips

### Evaluating Expressions

```bash
nix repl
```

```nix
myVar = "hello"
```
