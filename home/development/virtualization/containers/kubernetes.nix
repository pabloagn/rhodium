# home/development/virtualization/containers/kubernetes.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.development.virtualization.containers.kubernetes;
in
{
  options.rhodium.development.virtualization.containers.kubernetes = {
    enable = mkEnableOption "Enable Kubernetes containerization";
  };

  config = mkIf (config.rhodium.development.virtualization.containers.enable && cfg.enable) {
    home.packages = with pkgs; [
      kubectl
      kubernetes-helm
      kubernetes-krew
      kubernetes-kubectx
      kubernetes-kubectx-kubens
      kubernetes-kubectx-kubectl-switch
    ];
  };
}
