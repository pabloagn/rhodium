# modules/desktop/applications/default.nix

{ lib, config, pkgs, ... }:

let
  editorPkgs = {
    neovim = pkgs.neovim;
    helix = pkgs.helix;
    emacs = pkgs.emacs;
    # TODO: vscode would be via home-manager.users.<name>.programs.vscode.enable
  };
  fileManagerPkgs = {
    dolphin = pkgs.dolphin;
    nautilus = pkgs.nautilus;
    thunar = pkgs.thunar;
    yazi = pkgs.yazi;
    lf = pkgs.lf;
    nnn = pkgs.nnn;
  };
in
{
  config = {
    environment.systemPackages =
      (map (editorName: editorPkgs."${editorName}") config.mySystem.userEditors.enable)
      ++ (lib.optional (config.mySystem.hostProfile == "gui-desktop") fileManagerPkgs."${config.mySystem.desktop.fileManager}");
  };
}
