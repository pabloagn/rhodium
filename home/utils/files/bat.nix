{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    themes = {

      catppuccin-mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "/Catppuccin-mocha.tmTheme";
      };

      tokyonight_night = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "188c037a8fb5d0f39a0391d48c82d49c69d80097";
          sha256 = "0vwy6qzh206xhk6pds25c6020nlh51v6xf33kqa998l2yq7dmf78";
        };

        # Path to the theme file within the fetched repository
        file = "/extras/sublime/tokyonight_night.tmTheme";
      };
    };

    config = {
      style = "plain";
      theme = "tokyonight_night";
    };
  };
}
