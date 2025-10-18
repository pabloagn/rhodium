{
  user,
  pkgs,
  ...
}:
let
  userfullName = user.fullName;
  userEmail = user.emailMain;
in
{
  home.packages = with pkgs; [
    commitizen # Commit rules for projects
    serie # Rich TUI commit graph
  ];

  programs.git = {
    enable = true;
    userName = userfullName;
    userEmail = userEmail;

    extraConfig = {
      init.defaultBranch = "main";
    };

    ignores = [
      # Editor files
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/"
      ".idea/"

      # OS files
      ".DS_Store"
      "Thumbs.db"

      # Build artifacts
      "*.o"
      "*.so"
      "*.a"
      "*.out"

      # Logs
      "*.log"

      # Temporary files
      "*.tmp"
      "*.bak"
      ".cache/"
    ];

    delta = {
      enable = true; # View file diffs
    };

    riff = {
      enable = false; # View file diffs. Either this or delta.
    };
  };

  programs.gh = {
    enable = true; # GitHub CLI Tool
  };

  programs.gitui = {
    enable = true; # Blazing fast terminal-ui for Git written in Rust
  };

  programs.lazygit = {
    enable = true; # Simple terminal UI for git commands
  };
}
