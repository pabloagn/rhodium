let
  apps = import ./apps.nix;
  behaviour = import ./behaviour.nix;
  theme = import ./theme.nix;
  metadata = import ./metadata.nix;
in
{
  inherit (apps) apps profiles;
  inherit (behaviour) behaviour;
  inherit (theme) theme;
  inherit metadata;
}
