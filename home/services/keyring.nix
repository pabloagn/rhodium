{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-system-keyring;
in
{
  options.userExtraServices.rh-system-keyring = {
    enable = mkEnableOption "System keyring for GUI applications";
  };

  config = mkIf cfg.enable {
    services.gnome-keyring = {
      enable = true;
      components = [
        "secrets"
        "pkcs11"
      ];
    };

    # Install seahorse for GUI management
    home.packages = with pkgs; [
      seahorse # GUI to manage the keyring
      libsecret # CLI tools (secret-tool)
    ];
  };
}
