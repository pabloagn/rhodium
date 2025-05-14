# modules/desktop/terminal/default.nix

{ lib, config, pkgs, ... }:

{
  # Only make if some terminals are requested
  config = lib.mkIf (config.mySystem.userTerminals.enable != []) {
    environment.systemPackages = map (termName: pkgs."${termName}") config.mySystem.userTerminals.enable;

    # Setting a true "default terminal" (for xdg-open etc.) is complex and DE-dependent.
    # For now, this option mainly ensures installation and can be used by theme/config modules.
    # The `modules/themes/apply.nix` would use `config.mySystem.userTerminals.default`
    # to know which terminal to apply specific theming to (e.g., Alacritty settings).
  };
}
