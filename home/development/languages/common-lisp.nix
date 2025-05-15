# home/development/languages/common-lisp.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.commonLisp;
in
{
  options.home.development.languages.commonLisp = {
    enable = mkEnableOption "Enable Common Lisp development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Runtimes
      sbcl # Steel Bank Common Lisp
      # clisp # GNU CLISP
      # ecl # Embeddable Common Lisp

      # Build/Utility
      roswell # Lisp implementation installer and launcher

      # Language Server (often managed via Roswell or editor plugins)
      # common-lisp-language-server # If available as a direct package
    ];
    # Note: Quicklisp is typically installed and managed within the Lisp environment.
  };
}
