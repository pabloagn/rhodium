# home/options.nix

{ lib, ... }:

{
  options.myHome = {
    # User roles assigned to this home configuration
    roles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Roles assigned to this home configuration";
      example = ''[ "admin" "developer" ]'';
    };

    # User profile for this home configuration
    profile = lib.mkOption {
      type = lib.types.enum [ "minimal" "developer" "desktop" "full" ];
      default = "minimal";
      description = "Profile type for this home configuration";
    };

    # User preferences
    preferences = {
      terminal = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Preferred terminal emulator";
      };

      editor = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Preferred text editor";
      };

      browser = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Preferred web browser";
      };
    };
  };
}
