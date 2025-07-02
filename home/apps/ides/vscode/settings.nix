{...}: {
  programs.vscode = {
    profiles = {
      default = {
        userSettings = {
          # --- Window ---
          "window.title" = "Rhodium";

          # Workbench
          # "workbench.colorCustomizations" = {
          #   "[Kanso]" = {
          #     "editor.background" = "#141518";
          #     "editor.lineHighlightBackground" = "#1f2233";
          #     "editor.selectionBackground" = "#24282f";
          #     "editor.findMatchBackground" = "#2e3c57";
          #     "editorWhitespace.foreground" = "#3b4048";
          #     "editorCursor.foreground" = "#d9dee8";
          #     "editorIndentGuide.background1" = "#232530";
          #     "editorIndentGuide.activeBackground1" = "#393b4d";
          #     "sideBar.background" = "#141518";
          #     "sideBar.foreground" = "#abb2bf";
          #     "sideBarTitle.foreground" = "#abb2bf";
          #     "sideBarSectionHeader.background" = "#181a1f";
          #     "sideBarSectionHeader.foreground" = "#abb2bf";
          #     "activityBar.background" = "#141518";
          #     "activityBar.foreground" = "#cbc2c4";
          #     "activityBar.inactiveForeground" = "#9794a3";
          #     "titleBar.activeBackground" = "#141518";
          #     "titleBar.activeForeground" = "#a9adb1";
          #     "activityBarBadge.background" = "#d4b89b";
          #     "activityBarBadge.foreground" = "#1a1b26";
          #     "statusBar.background" = "#141518";
          #     "statusBar.foreground" = "#9794a3";
          #     "editorGroupHeader.tabsBackground" = "#141518";
          #     "editorGroupHeader.tabsBorder" = "#141518";
          #     "tab.activeBackground" = "#141518";
          #     "tab.activeForeground" = "#d0d9e6";
          #     "tab.inactiveBackground" = "#13141c";
          #     "tab.inactiveForeground" = "#8792aa";
          #     "tab.activeBorder" = "#8792aa";
          #     "breadcrumb.background" = "#141518";
          #     "breadcrumb.foreground" = "#8792aa";
          #     "breadcrumb.focusForeground" = "#d5d8da";
          #     "breadcrumb.activeSelectionForeground" = "#ffffff";
          #     "breadcrumbPicker.background" = "#1c1e26";
          #     "list.activeSelectionBackground" = "#1e2126";
          #     "list.activeSelectionForeground" = "#d0d9e6";
          #     "list.inactiveSelectionBackground" = "#1c1f25";
          #     "list.hoverBackground" = "#1c1f25";
          #     "scrollbarSlider.background" = "#2a2c3a80";
          #     "scrollbarSlider.hoverBackground" = "#3b3f5280";
          #     "scrollbarSlider.activeBackground" = "#3b3f52";
          #   };
          # };

          "workbench.editor.decorations.colors" = true;
          "workbench.editor.decorations.badges" = true;
          "workbench.editor.labelFormat" = "short";
          "workbench.editor.limit.enabled" = true;
          "workbench.editor.limit.value" = 15;
          "workbench.tree.indent" = 20;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.colorTheme" = "Kanso Zen";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.panel.defaultLocation" = "bottom";
          "workbench.activityBar.location" = "top";

          # --- Editor ---
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
          "editor.detectIndentation" = false;
          "editor.suggestSelection" = "first";
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.bracketPairs" = "active";
          "editor.guides.bracketPairsHorizontal" = true;
          "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
          "editor.rulers" = [80 120];
          "editor.linkedEditing" = true;
          "editor.suggest.insertMode" = "replace";
          "editor.inlineSuggest.enabled" = true;
          "editor.codeLens" = true;
          "editor.unicodeHighlight.ambiguousCharacters" = true;
          "editor.unicodeHighlight.invisibleCharacters" = true;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', 'FiraCode Nerd Font', 'Fira Code', Menlo, Monaco, 'Courier New', monospace";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 14;
          "editor.lineHeight" = 1.6;
          "editor.wordWrap" = "on";
          "editor.minimap.enabled" = true;
          "editor.minimap.side" = "right";
          "editor.minimap.scale" = 1;
          "editor.minimap.renderCharacters" = true;
          "editor.minimap.showSlider" = "always";
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.cursorStyle" = "line";
          "editor.smoothScrolling" = true;
          "editor.formatOnSave" = false;

          # --- Todo Tree ---
          "todo-tree.general.statusBar" = "total";
          "todo-tree.general.showActivityBarBadge" = false;
          "todo-tree.general.showIconsInsteadOfTagsInStatusBar" = true;

          # --- Git/scm ---
          "scm.countBadge" = "off";
          "git.countBadge" = "off";
          "git.enableSmartCommit" = true;
          "git.confirmSync" = false;
          "git.autofetch" = true;
          "git.ignoreLimitWarning" = true;

          # --- Language-specific Editor Settings ---
          "editor.tokenColorCustomizations" = {
            "[Kanso]" = {
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

          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
            "editor.formatOnSave" = false;
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "explicit";
            };
          };

          "[lua]" = {
            "editor.defaultFormatter" = "sumneko.lua";
            "editor.formatOnSave" = false;
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "explicit";
            };
          };

          "[shellscript]" = {
            "editor.defaultFormatter" = "foxundermoon.shell-format";
            "editor.formatOnSave" = false;
            "editor.codeActionsOnSave" = {
              "source.fixAll.shellcheck" = "explicit";
            };
          };

          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
            "editor.formatOnSave" = false;
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "explicit";
              "source.organizeImports" = "explicit";
            };
          };

          "[json]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = false;
          };

          "[jsonc]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = false;
          };

          "[markdown]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = false;
            "files.trimTrailingWhitespace" = false;
          };

          "[yaml]" = {
            "editor.defaultFormatter" = "redhat.vscode-yaml";
            "editor.formatOnSave" = false;
          };

          "[toml]" = {
            "editor.defaultFormatter" = "tamasfe.even-better-toml";
            "editor.formatOnSave" = false;
          };

          # --- Markdown ---
          "markdownlint.config" = {
            "MD029" = false;
            "MD024" = false;
          };

          # --- Explorer ---
          "explorer.compactFolders" = true;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;

          # --- Problems ---
          "problems.autoReveal" = true;
          "problems.showCurrentInStatus" = true;

          # --- Files & Search ---
          "files.encoding" = "utf8";
          "files.eol" = "\n";
          "files.insertFinalNewline" = true;
          "files.trimTrailingWhitespace" = true;
          "files.exclude" = {
            "**/.git" = true;
            "**/.svn" = true;
            "**/.hg" = true;
            "**/CVS" = true;
            "**/.DS_Store" = true;
            "**/Thumbs.db" = true;
            "**/__pycache__" = true;
            "**/.venv" = true;
            "**/.ruff_cache" = true;
            "**/.mypy_cache" = true;
            "**/.pytest_cache" = true;
            "**/result" = true;
          };
          "search.exclude" = {
            "**/.git" = true;
            "**/.svn" = true;
            "**/.hg" = true;
            "**/CVS" = true;
            "**/.DS_Store" = true;
            "**/Thumbs.db" = true;
            "**/__pycache__" = true;
            "**/.venv" = true;
            "**/.ruff_cache" = true;
            "**/.mypy_cache" = true;
            "**/.pytest_cache" = true;
            "**/result" = true;
          };
          "files.watcherExclude" = {
            "**/.git/objects/**" = true;
            "**/.git/subtree-cache/**" = true;
            "**/.hg/store/**" = true;
            "**/__pycache__" = true;
            "**/.pytest_cache" = true;
            "**/.mypy_cache" = true;
            "**/.ruff_cache" = true;
            "**/result" = true;
          };
          "files.associations" = {
            "*.jpg" = "binary";
            "*.jpeg" = "binary";
            "*.png" = "binary";
            "*.gif" = "binary";
            "*.ico" = "binary";
            "*.icns" = "binary";
            "*.nix" = "nix";
          };

          # --- Language Servers ---
          "python.defaultInterpreterPath" = "python3";
          "python.languageServer" = "Pylance";
          "python.analysis.typeCheckingMode" = "basic";
          "python.analysis.autoImportCompletions" = true;
          "python.analysis.indexing" = true;
          "ruff.importStrategy" = "fromEnvironment";
          "python.testing.pytestEnabled" = true;
          "python.testing.unittestEnabled" = false;
          "python.testing.pytestArgs" = ["tests"];
          "python.analysis.diagnosticMode" = "openFilesOnly";
          "python.analysis.diagnosticSeverityOverrides" = {
            "reportMissingImports" = "none";
            "reportMissingModuleSource" = "none";
          };

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.serverSettings" = {
            "nil" = {
              "formatting" = {
                "command" = ["nixpkgs-fmt"];
              };
            };
          };

          "Lua.diagnostics.globals" = ["vim"];
          "Lua.workspace.library" = ["\${3rd}/love2d/library"];
          "Lua.workspace.checkThirdParty" = false;

          # --- Spell Checker ---
          "cSpell.enabled" = false;
          "cSpell.validateDirectives" = true;
          "cSpell.ignorePaths" = [
            "**/node_modules/**"
            "**/.git/**"
            "**/__pycache__/**"
            "**/.venv/**"
            "**/.ruff_cache/**"
            "**/.mypy_cache/**"
            "**/.pytest_cache/**"
            "**/result/**"
          ];
          "cSpell.words" = [
            "autostart"
            "bspwm"
            "catppuccin"
            "flake"
            "hyprland"
            "hyprpaper"
            "nixos"
            "nixpkgs"
            "rofi"
            "starship"
            "systemd"
            "waybar"
            "wezterm"
            "wlroots"
            "yazi"
          ];

          # --- Terminal ---
          "terminal.integrated.cursorBlinking" = true;
          "terminal.integrated.smoothScrolling" = true;

          # --- Extensions ---
          "extensions.autoCheckUpdates" = false;
          "extensions.ignoreRecommendations" = true;

          # --- Misc ---
          "security.workspace.trust.enabled" = false;
          "workbench.startupEditor" = "none";
          "redhat.telemetry.enabled" = false;
        };
      };
    };
  };
}
