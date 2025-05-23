# home/development/ides/vscode/languages.nix

{
  # Language-specific settings and formatters

  # Rust
  "editor.tokenColorCustomizations" = {
    "[Tokyo Night]" = {
      "textMateRules" = [
        {
          "scope" = "variable.other.rust";
          "settings" = {
            "foreground" = "#e7d721";
          };
        }
      ];
    };
  };

  "[rust]" = {
    "editor.semanticHighlighting.enabled" = false;
    "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll" = "explicit";
    };
  };

  # Nix
  "[nix]" = {
    "editor.defaultFormatter" = "jnoortheen.nix-ide";
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll" = "explicit";
    };
  };

  # Lua
  "[lua]" = {
    "editor.defaultFormatter" = "sumneko.lua";
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll" = "explicit";
    };
  };

  # Shell/Bash
  "[shellscript]" = {
    "editor.defaultFormatter" = "foxundermoon.shell-format";
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll.shellcheck" = "explicit";
    };
  };

  # Python
  "[python]" = {
    "editor.defaultFormatter" = "charliermarsh.ruff";
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll" = "explicit";
      "source.organizeImports" = "explicit";
    };
  };

  # JSON
  "[json]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = false;
  };

  # JSONC
  "[jsonc]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = false;
  };

  # Markdown
  "[markdown]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = false;
    "files.trimTrailingWhitespace" = false;
  };

  "markdownlint.config" = {
    "MD029" = false;
    "MD024" = false;
  };

  # YAML
  "[yaml]" = {
    "editor.defaultFormatter" = "redhat.vscode-yaml";
    "editor.formatOnSave" = false;
  };

  # TOML
  "[toml]" = {
    "editor.defaultFormatter" = "tamasfe.even-better-toml";
    "editor.formatOnSave" = false;
  };

  # Language Server settings

  # Python
  "python.defaultInterpreterPath" = "python3";
  "python.languageServer" = "Pylance";
  "python.analysis.typeCheckingMode" = "basic";
  "python.analysis.autoImportCompletions" = true;
  "python.analysis.indexing" = true;
  "ruff.importStrategy" = "fromEnvironment";
  "python.testing.pytestEnabled" = true;
  "python.testing.unittestEnabled" = false;
  "python.testing.pytestArgs" = [ "tests" ];
  "python.analysis.diagnosticMode" = "openFilesOnly";
  "python.analysis.diagnosticSeverityOverrides" = {
    "reportMissingImports" = "none";
    "reportMissingModuleSource" = "none";
  };

  # Nix
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nil";
  "nix.serverSettings" = {
    "nil" = {
      "formatting" = {
        "command" = [ "nixpkgs-fmt" ];
      };
    };
  };

  # Lua
  "Lua.diagnostics.globals" = [ "vim" ];
  "Lua.workspace.library" = [ "\${3rd}/love2d/library" ];
  "Lua.workspace.checkThirdParty" = false;
}
