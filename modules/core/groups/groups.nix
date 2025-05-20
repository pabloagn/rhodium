# modules/core/groups/groups.nix

{ lib, config, hostData, ... }:

{
  options.rhodium.host = {
    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = hostData.memberOfGroups or [];
      description = ''
        A list of logical group names this host belongs to.
        Users whose 'hostGroups' attribute (defined in user data)
        contains any of these group names will be created on this host.
      '';
      example = [ "desktops" "production-servers" ];
    };
  };
}
