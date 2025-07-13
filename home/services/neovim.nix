{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-neovim-daemon;
in
{
  options.userExtraServices.rh-neovim-daemon = {
    enable = mkEnableOption "Neovim daemon for instant startup";
    socketPath = mkOption {
      type = types.str;
      default = "/tmp/nvimsocket";
      description = "Path to the Neovim server socket";
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-neovim-daemon = {
      Unit = {
        Description = "Neovim daemon";
        PartOf = [ "default.target" ];
        After = [ "default.target" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.neovim}/bin/nvim --headless --listen ${cfg.socketPath}";
        ExecStop = "${pkgs.neovim}/bin/nvim --server ${cfg.socketPath} --remote-send ':qa!<CR>'";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };

    };
    # Alias for connecting to daemon
    home.shellAliases.nvim = "${pkgs.neovim}/bin/nvim --server ${cfg.socketPath} --remote-ui";
  };
}
