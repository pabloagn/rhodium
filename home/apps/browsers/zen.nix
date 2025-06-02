{ pkgs, inputs, ... }:

{
  home.packages = [
    # inputs.zen-browser.packages."${pkgs.system}".default
    # inputs.zen-browser.packages."${pkgs.system}".specific
    inputs.zen-browser.packages."${pkgs.system}".generic
  ];
}
