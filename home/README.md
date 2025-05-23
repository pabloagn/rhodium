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

### VS Code

#### Getting Started

Basic usage - just enable with defaults

```nix
rhodium.home.apps.development.ides.vscode.enable = true;
rhodium.home.apps.development.ides.vscode.stable.enable = true;
```

Or customize with specific theme and settings

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "tokyo-night"; # "tokyo-night" or "catppuccin-mocha"
  spelling.enable = true;
  
  # Global spelling dictionary additions
  spelling.globalDictionary = [
    "mycompany"
    "kubernetes"
    "dockerfile"
  ];
};
```

#### Advanced Usage

Try out any of these examples:

1. System development with workspace templates

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "tokyo-night";
  spelling.enable = true;
  
  workspaces = {
    rhodium-system = {
      enable = true;
      theme = "catppuccin-mocha"; # Override global theme
      folders = [
        { name = "Rhodium"; path = "."; }
        { name = "Home"; path = "home"; }
        { name = "Hosts"; path = "hosts"; }
        { name = "Modules"; path = "modules"; }
      ];
      extensions = [
        "jnoortheen.nix-ide"
        "rust-lang.rust-analyzer"
        "ms-python.python"
      ];
    };
  };
};
```

2. Web development workspace

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "tokyo-night";
  spelling.enable = true;
  
  workspaces = {
    web-development = {
      enable = true;
      folders = [
        { name = "Frontend"; path = "frontend"; }
        { name = "Backend"; path = "backend"; }
        { name = "Shared"; path = "shared"; }
      ];
      extensions = [
        "esbenp.prettier-vscode"
        "bradlc.vscode-tailwindcss"
        "ms-vscode.vscode-typescript-next"
      ];
      extraSettings = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.tabSize" = 2;
        "[typescript]"."editor.tabSize" = 2;
      };
    };
  };
};
```

3. Multiple VS Code variants with different themes

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  insiders.enable = true;
  vscodium.enable = true;
  theme = "catppuccin-mocha";
  spelling.enable = true;
};
```

4. Documentation and writing setup

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "tokyo-night";
  spelling.enable = true;
  
  workspaces = {
    documentation = {
      enable = true;
      spelling.enable = true;
      folders = [
        { name = "Docs"; path = "docs"; }
        { name = "README"; path = "."; }
      ];
      extensions = [
        "yzhang.markdown-all-in-one"
        "davidanson.vscode-markdownlint"
        "bierner.markdown-mermaid"
        "james-yu.latex-workshop"
      ];
      extraSettings = {
        "files.trimTrailingWhitespace" = false;
        "editor.wordWrap" = "on";
        "editor.rulers" = [ 80 ];
      };
    };
  };
};
```

5. Data science and Python development

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "tokyo-night";
  spelling.enable = true;
  
  workspaces = {
    data-science = {
      enable = true;
      folders = [
        { name = "Notebooks"; path = "notebooks"; }
        { name = "Data"; path = "data"; }
        { name = "Scripts"; path = "scripts"; }
      ];
      extensions = [
        "ms-python.python"
        "ms-python.vscode-pylance"
        "charliermarsh.ruff"
        "ms-toolsai.jupyter"
      ];
      extraSettings = {
        "python.defaultInterpreterPath" = "./venv/bin/python";
        "python.testing.pytestEnabled" = true;
        "editor.rulers" = [ 88 120 ];
      };
    };
  };
};
```

6. Container and DevOps workspace

```nix
rhodium.home.apps.development.ides.vscode = {
  enable = true;
  stable.enable = true;
  theme = "catppuccin-mocha";
  spelling.enable = true;
  
  workspaces = {
    devops = {
      enable = true;
      folders = [
        { name = "Infrastructure"; path = "infra"; }
        { name = "Containers"; path = "docker"; }
        { name = "CI/CD"; path = ".github"; }
      ];
      extensions = [
        "ms-azuretools.vscode-docker"
        "ms-kubernetes-tools.vscode-kubernetes-tools"
        "redhat.vscode-yaml"
        "github.vscode-github-actions"
      ];
      spelling.globalDictionary = [
        "kubernetes"
        "kubectl"
        "dockerfile"
        "github"
      ];
    };
  };
};
```

#### Available Themes

- **phantom-black**: Gothic, modernist, minimalistic
- **tokyo-night**: Dark theme with blue/purple accents (default)
- **catppuccin-mocha**: Warm, cozy dark theme with pastel colors

#### Available Variants

- **stable**: Standard VS Code release
- **insiders**: Preview builds with latest features
- **vscodium**: FOSS version without Microsoft telemetry

#### Workspace Features

- **Theme inheritance**: Workspaces inherit global theme unless overridden
- **Folder organization**: Define custom folder structures per workspace
- **Extension recommendations**: Specify extensions per workspace
- **Settings overrides**: Add workspace-specific settings
- **Spelling dictionaries**: Workspace-specific spell checking

## Desktop

## Development

## Environment

## Profiles

## Security

## Shell

## System

## Virtualization
