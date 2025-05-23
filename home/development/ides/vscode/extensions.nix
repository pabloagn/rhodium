# home/development/ides/vscode/extensions.nix

{
  extensions = [

    # Core editor
    "EditorConfig.EditorConfig"
    "streetsidesoftware.code-spell-checker"
    "Gruntfuggly.todo-tree"
    "aaron-bond.better-comments"
    "christian-kohler.path-intellisense"
    "enkia.tokyo-night"
    "pkief.material-icon-theme"
    "naumovs.color-highlight"
    "ctc.vscode-tree-extension"
    "johnpapa.vscode-peacock"
    "kisstkondoros.vscode-gutter-preview"
    "sleistner.vscode-fileutils"
    "visualstudioexptteam.vscodeintellicode"
    "wayou.vscode-todo-highlight"

    # Git
    "github.vscode-github-actions"

    # Containers & Remote
    "ms-azuretools.vscode-containers"
    "ms-azuretools.vscode-docker"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-ssh"
    "ms-vscode-remote.remote-ssh-edit"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode-remote.vscode-remote-extensionpack"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.makefile-tools"

    # Nix
    "jnoortheen.nix-ide"
    "bbenoist.Nix"
    "mkhl.direnv"
    "pinage404.nix-extension-pack"
    "arrterian.nix-env-selector"
    "twxs.cmake"

    # Lua
    "sumneko.lua"

    # Shell/Bash
    "timonwong.shellcheck"
    "foxundermoon.shell-format"
    "rogalmic.bash-debug"
    "mads-hartmann.bash-ide-vscode"

    # Python
    "ms-python.python"
    "ms-python.vscode-pylance"
    "charliermarsh.ruff"
    "njpwerner.autodocstring"
    "ms-python.debugpy"
    "ms-python.mypy-type-checker"
    "zeshuaro.vscode-python-poetry"

    # Rust
    "rust-lang.rust-analyzer"

    # HTML & CSS
    "ecmel.vscode-html-css"

    # Haskell
    "haskell.haskell"
    "justusadam.language-haskell"

    # CPP
    "vadimcn.vscode-lldb"

    # Data formats
    "redhat.vscode-yaml"
    "tamasfe.even-better-toml"
    "mechatroner.rainbow-csv"
    "esbenp.prettier-vscode"
    "davidwang.ini-for-vscode"
    "dlasagno.rasi"
    "mikestead.dotenv"

    # Documentation
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"
    "bierner.markdown-mermaid"
    "james-yu.latex-workshop"
    "yzane.markdown-pdf"

    # Media
    "jock.svg"
    "hediet.vscode-drawio"
  ];

  # Extension-specific settings
  settings = {
    # Tree extension
    "todo-tree.general.statusBar" = "total";
    "todo-tree.general.showActivityBarBadge" = false;
    "todo-tree.general.showIconsInsteadOfTagsInStatusBar" = true;

    # Git and SCM
    "scm.countBadge" = "off";
    "git.countBadge" = "off";
    "git.enableSmartCommit" = true;
    "git.confirmSync" = false;
    "git.autofetch" = true;
    "git.ignoreLimitWarning" = true;

    # Spell checker
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

    # Explorer
    "explorer.compactFolders" = true;
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    # Problems
    "problems.autoReveal" = true;
    "problems.showCurrentInStatus" = true;
  };
}
