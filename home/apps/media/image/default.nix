# home/apps/media/image/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    # Image managers
    {
      name = "immich";
      pkg = pkgs.immich;
      description = "Self-hosted photo management service";
    }
    {
      name = "photoprism";
      pkg = pkgs.photoprism;
      description = "Self-hosted photo management service";
    }
    {
      name = "photoview";
      pkg = pkgs.photoview;
      description = "Self-hosted photo management service";
    }
    {
      name = "nextcloud-photos";
      pkg = pkgs.nextcloud-photos;
      description = "Self-hosted photo management service";
    }
    {
      name = "librephotos";
      pkg = pkgs.librephotos;
      description = "Self-hosted photo management service";
    }

    # Image viewers
    {
      name = "feh";
      pkg = pkgs.feh;
      description = "Fast and light imlib2-based image viewer (used throughout the system)";
    }
    {
      name = "sxiv";
      pkg = pkgs.sxiv;
      description = "Simple X Image Viewer";
    }

    # Image editors and manipulation
    {
      name = "imagemagick";
      pkg = pkgs.imagemagick;
      description = "Create, edit, compose, or convert bitmap images";
    }
    {
      name = "inkscape";
      pkg = pkgs.inkscape;
      description = "Vector graphics editor";
    }
    {
      name = "figma-linux";
      pkg = pkgs.figma-linux;
      description = "Unofficial Figma desktop application for Linux";
    }
    {
      name = "blender";
      pkg = pkgs.blender;
      description = "3D Creation/Animation/Publishing System";
    }
    {
      name = "exiv2";
      pkg = pkgs.exiv2;
      description = "Image metadata manipulation tool";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Image applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
