# modules/development/languages/common-lisp.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.commonLisp;
in
{
  options.rhodium.system.development.languages.commonLisp = {
    enable = mkEnableOption "Enable Common Lisp development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Runtimes
      sbcl # Steel Bank Common Lisp
      # clisp # GNU CLISP
      # ecl # Embeddable Common Lisp

      # Build/Utility
      roswell # Lisp implementation installer and launcher

      # Language Server (often managed via Roswell or editor plugins)
      # Example: roswell can install cl-lsp (Common Lisp Language Server)
      # common-lisp-language-server # If available as a direct package
    ];
    # Note: Quicklisp is typically installed and managed within the Lisp environment.
  };
}
