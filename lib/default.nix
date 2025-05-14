# library/default.nix

{ lib ? null, pkgs ? null, inputs ? null, self ? null }:

let
  args = { inherit lib pkgs inputs self; };

  mkHost = import ./mk-host.nix args;
  mkUser = import ./mk-user.nix args;

in
{
  inherit (mkHost) hostTemplates mkHostsFromManifest;
  inherit (mkUser) userRoleTemplates mkHomeConfig mkUsersFromManifest;
}
