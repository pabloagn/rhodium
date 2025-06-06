{
  description = "Rhodium Flakes | Fish Plugins Collection";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs"; # This gets overriden by follows
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    colored-man = {
      url = "github:decors/fish-colored-man";
      flake = false;
    };

    z = {
      url = "github:jethrokuan/z";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , colored-man
    , z
    }@inputs:
    let
      plugins = {
        colored-man = {
          name = "colored-man";
          src = colored-man;
        };

        z = {
          name = "z";
          src = z;
        };
      };
    in
    {
      inherit plugins;

      sources = {
        inherit colored-man z;
      };

      pluginsList = builtins.attrValues plugins;
    };
}
