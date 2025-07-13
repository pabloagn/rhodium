{
  pkgs,
  inputs,
}:
{
  tokyonight_night = {
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "tokyonight.nvim";
      rev = "b262293ef481b0d1f7a14c708ea7ca649672e200";
      sha256 = "1cd8wxgicfm5f6g7lzqfhr1ip7cca5h11j190kx0w52h0kbf9k54";
    };
    files = {
      bat = "/extras/sublime/tokyonight_night.tmTheme";
    };
  };
  kanso-zen = {
    src = inputs.kanso-nvim; # NOTE: Uses flake inputs directly
    files = {
      bat = "/extras/tmTheme/kanso-zen.tmTheme";
    };
  };
}
