{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./eza.nix
    ./fzf.nix
    ./mcfly.nix
    ./skim.nix # A fzf alternative written in rust
    ./television.nix # A telescope-inspired rust picker
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
