{ pkgs, ... }:

let
  cleanScript = pkgs.writeShellScriptBin "clean-nvim" ''
    rm -rf ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim ~/.config/nvim/.cache
  '';
in {
  systemd.user.services.clean-nvim = {
    Unit = {
      Description = "Clean Neovim State";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${cleanScript}/bin/clean-nvim";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}

