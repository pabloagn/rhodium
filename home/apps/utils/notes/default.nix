# home/apps/utils/notes/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    {
      name = "anytype";
      pkg = pkgs.anytype;
      description = "An open-source, local-first, p2p, and end-to-end encrypted object-based collaboration OS";
    }
    {
      name = "appflowy";
      pkg = pkgs.appflowy;
      description = "An open-source alternative to Notion";
    }
    {
      name = "joplin-desktop";
      pkg = pkgs.joplin-desktop;
      description = "Joplin desktop note-taking and to-do application";
    }
    {
      name = "joplin-server";
      pkg = pkgs.joplin-server;
      description = "Joplin server";
    }
    {
      name = "logseq";
      pkg = pkgs.logseq;
      description = "A privacy-first, open-source platform for knowledge management and collaboration";
    }
    {
      name = "obsidian";
      pkg = pkgs.obsidian;
      description = "A powerful knowledge base that works on local Markdown files";
    }
    {
      name = "roam";
      pkg = pkgs.roam-research-app;
      description = "Roam Research note-taking application (wrapper)";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Note-taking applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
