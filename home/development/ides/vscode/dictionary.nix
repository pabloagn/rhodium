# home/development/ides/vscode/dictionary.nix

{
  "cSpell.customDictionaries" = {
    "project-dictionary" = {
      "name" = "project-dictionary";
      "path" = "\${workspaceFolder}/.vscode/dictionary.txt";
      "addWords" = true;
      "scope" = "workspace";
    };
  };

  "cSpell.dictionaries" = [ "project-dictionary" ];
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

  # TODO: Inject from assets dictionaries
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
}
