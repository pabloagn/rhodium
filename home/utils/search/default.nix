{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./eza.nix
    ./fzf.nix
    ./mcfly.nix
    ./skim.nix
  ];
  programs = {
    jq = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    ripgrep-all = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    fselect # Find files with SQL-like queries
    plocate # A much faster locate
    sd # Sed alternative
  ];
}
