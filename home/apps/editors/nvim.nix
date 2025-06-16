{pkgs, ...}: {
  imports = [
    ./nvim
  ];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      neovim-remote
    ];
  };
}
