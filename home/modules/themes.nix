{pkgs}: {
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
  kanso_zen = {
    src = pkgs.fetchFromGitHub {
      owner = "pabloagn";
      repo = "kanso.nvim";
      rev = "691f9cec91c49ff7101f1fb27c3f57e1cf6049f6";
      hash = "sha256-Dk1DxgQnx7YiO659Y+X5v9ZLe/ujpiJWuxIFHUTKRUA=";
    };
    files = {
      bat = "/extras/tmTheme/kanso_zen.tmTheme";
    };
  };
}
