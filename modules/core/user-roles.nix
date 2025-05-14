# modules/core/user-roles.nix

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mySystem.userRoles;
in
{
  options.mySystem.userRoles = {

    # Define role options
    definitions = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          description = mkOption {
            type = types.str;
            description = "Description of this role";
          };
          groups = mkOption {
            type = types.listOf types.str;
            description = "Groups that users with this role should belong to";
          };
          packages = mkOption {
            type = types.listOf types.package;
            default = [];
            description = "Packages that should be available to users with this role";
          };
          homeModules = mkOption {
            type = types.listOf types.str;
            default = [];
            description = "Home-manager modules to enable for this role";
          };
        };
      });
      default = {
        admin = {
          description = "Administrator with system management capabilities";
          groups = [ "wheel" "networkmanager" "sudo" ];
          packages = with pkgs; [ htop iotop dstat ];
          homeModules = [ "admin" ];
        };
        developer = {
          description = "Software developer with programming tools";
          groups = [ "docker" "vboxusers" "dialout" ];
          packages = with pkgs; [ git gcc gnumake nodejs python3 ];
          homeModules = [ "developer" ];
        };
        desktop = {
          description = "Desktop user with graphical applications";
          groups = [ "audio" "video" "input" ];
          packages = with pkgs; [ firefox libreoffice vlc ];
          homeModules = [ "desktop" ];
        };
      };
      description = "Available user roles and their configurations";
    };

    # Define users, their passwords, and their roles
    users = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          description = mkOption {
            type = types.str;
            default = "";
          };

          initialPassword = mkOption {
            type = types.nullOr types.str;
            default = null;
          };

          hashedPassword = mkOption {
            type = types.nullOr types.str;
            default = null;
          };

          shell = mkOption {
            type = types.package;
            default = pkgs.bash;
          };

          roles = mkOption {
            type = types.listOf (types.enum (attrNames cfg.definitions));
            default = [ ];
          };

          extraGroups = mkOption {
            type = types.listOf types.str;
            default = [ ];
          };

          hosts = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = "List of hostnames where this user should be enabled";
          };

        };
      });
      default = { };
    };
  };

  config = {
    # No implementation here - this just defines the options
  };
}
