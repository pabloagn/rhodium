{ ... }:
{
  imports = [
    ./atuin.nix
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
}
