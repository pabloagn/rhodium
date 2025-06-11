{ user, ... }:

let
  userfullName = user.fullName;
  userEmail = user.emailMain;
in
{
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
      enable = true;
    };

    riff = {
      enable = true;
    };
  };
}
