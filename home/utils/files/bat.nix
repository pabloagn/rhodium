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

      tokyonight_night = { # v4.11.0
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "b262293ef481b0d1f7a14c708ea7ca649672e200";
          sha256 = "1cd8wxgicfm5f6g7lzqfhr1ip7cca5h11j190kx0w52h0kbf9k54";
        };
        file = "/extras/sublime/tokyonight_night.tmTheme";
      };
    };

    config = {
      style = "plain";
      theme = "tokyonight_night";
    };
  };
}
