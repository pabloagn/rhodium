let
  apps = import ./apps.nix;
  behaviour = import ./behaviour.nix;
  theme = import ./theme.nix;
in
{
  inherit (apps) apps profiles;
  inherit (behaviour) behaviour;
  inherit (theme) theme;
}
