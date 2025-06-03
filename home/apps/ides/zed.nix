{ pkgs, ... }:

{
  imports = [
    ./zed
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
  };
}
