{ config, pkgs, ... }:

{
  # TODO: Do this with sops the proper way
  # programs.ssh.matchBlocks = {
  #   "github.com" = {
  #     user = "git";
  #     hostname = "github.com";
  #     identityFile = "$HOME/.ssh/nixos";
  #   };
  # };
}
