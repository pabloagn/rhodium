# home/apps/terminal/utils/navigation/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.navigation;
  categoryName = "navigation";

  packageSpecs = [
    { name = "eza"; pkg = pkgs.eza; description = "Modern ls & exa replacement with enhanced features"; }
    { name = "less"; pkg = pkgs.less; description = "Pager with more features than more"; }
    { name = "fd"; pkg = pkgs.fd; description = "Modern alternative to find"; }
    { name = "ripgrep"; pkg = pkgs.ripgrep; description = "Fast grep alternative focused on source code search"; }
    { name = "sd"; pkg = pkgs.sd; description = "Intuitive find & replace CLI (sed alternative)"; }
    { name = "rsync"; pkg = pkgs.rsync; description = "Fast, versatile file copying tool"; }
    { name = "rename"; pkg = pkgs.rename; description = "Powerful tool for batch renaming files"; }
    { name = "tree"; pkg = pkgs.tree; description = "Display directory structure as a tree"; }
    { name = "fzf"; pkg = pkgs.fzf; description = "General-purpose fuzzy finder"; }
    { name = "silver-searcher"; pkg = pkgs.silver-searcher; description = "Fast code searching tool (ag)"; }
    { name = "dua-cli"; pkg = pkgs.dua-cli; description = "Disk usage analyzer with terminal interface"; }
    { name = "dust"; pkg = pkgs.dust; description = "More intuitive du alternative with visual output"; }
    { name = "ncdu"; pkg = pkgs.ncdu; description = "Disk usage analyzer with ncurses interface"; }
  ];
in
{
  imports = [
    ./bat.nix
    ./lf.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}
