# Rhodium | Home

## Apps

### Helix

#### Getting Started

Basic usage - just enable with defaults

```nix
rhodium.home.apps.development.editors.helix.enable = true;
```

Or customize with specific profile and settings

```nix
rhodium.home.apps.development.editors.helix = {
  enable = true;
  profile = "developer";        # "developer", "minimal", or "writer"
  keyProfile = "vim";          # "vim", "vscode", "emacs", or "minimal"
  customTheme = "phantom";     # Use Rhodium themes +/- variants
  enabledLanguages = "all";    # "all", "minimal", or ["rust" "nix" "python"]

  # Add custom configuration overrides
  extraConfig = {
    editor = {
      rulers = [80 120];
      soft-wrap.enable = true;
      completion-trigger-len = 2;
    };

    # Add custom key mappings
    keys.normal."," = {
      "t" = ":toggle-option soft-wrap.enable";
      "r" = ":toggle-option editor.rulers";
    };
  };
};
```

#### Advanced Usage

Try out any of these examples:

1. Writer-focused configuration

```nix
rhodium.home.apps.development.editors.helix = {
  enable = true;
  profile = "writer";
  enabledLanguages = ["markdown" "latex" "nix"];
  extraConfig = {
    editor.soft-wrap.enable = true;
    editor.rulers = [80];
  };
};
```

2. Minimal configuration for quick edits

```nix
rhodium.home.apps.development.editors.helix = {
  enable = true;
  profile = "minimal";
  keyProfile = "minimal";
  enabledLanguages = "minimal";
};
```

3. Web development setup

````nix
rhodium.home.apps.development.editors.helix = {
  enable = true;
  profile = "developer";
 enabledLanguages = ["javascript" "typescript" "jsx" "tsx" "html" "css" "nix"];
 extraConfig = {
   editor.formatter.timeout_ms = 5000;
   keys.normal.space.f = "format_selections";
 };
};

4. Systems programming setup

```nix
rhodium.home.apps.development.editors.helix = {
  enable = true;
  profile = "developer";
  enabledLanguages = ["rust" "go" "nix" "toml"];
  customTheme = "phantom";
  extraConfig = {
    editor.auto-format = true;
    editor.completion-trigger-len = 1;
  };
};
````

## Desktop

## Development

## Environment

## Profiles

## Security

## Shell

## System

## Virtualization
