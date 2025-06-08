{
  description = "Rhodium Flakes | Fish Plugins Collection";

  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    # nixpkgs-unstable = {
    #   url = "github:NixOS/nixpkgs/nixos-unstable";
    # };

    colored-man = {
      url = "github:decors/fish-colored-man";
      flake = false;
    };

    # z = {
    #   url = "github:jethrokuan/z";
    #   flake = false;
    # };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    }@inputs:
    let
      plugins = {
        colored-man = {
          name = "colored-man";
          src = inputs.colored-man;
        };

        # z = {
        #   name = "z";
        #   src = inputs.z;
        # };
      };
    in
    {
      inherit plugins;
      sources = inputs;
      pluginsList = builtins.attrValues plugins;
    };
}
