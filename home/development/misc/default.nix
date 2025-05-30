{ config, lib, pkgs, ... }:
with lib;
{
  options = {
    programs.development.misc = {
      enable = mkEnableOption "Misc development tools" // {
        default = mkDefault false;
      };
    };
  };

  config = mkIf config.programs.development.misc.enable {
    home.packages = with pkgs; [
      postman
    ];
  };
}
