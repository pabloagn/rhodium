{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./fzf.nix
    ./mcfly.nix
    ./skim.nix
  ];
  programs = {
    fzf = {
      enable = true;
    };

    eza = {
      enable = true;
    };

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
  ];
}
