{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- General ---
    nodePackages.prettier
    prettierd # NOTE: Prettier running as daemon
  ];
}
