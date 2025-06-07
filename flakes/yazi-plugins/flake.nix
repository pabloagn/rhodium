{
  description = "Rhodium Flakes | Yazi Plugins Collection";

  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    git = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    miller = {
      url = "github:Reledia/miller.yazi";
      flake = false;
    };

    full-border = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    yatline = {
      url = "github:imsi32/yatline.yazi";
      flake = false;
    };
  };

  outputs =
  {self
  , nixpkgs
  , yazi-plugins
  , ...
  }@inputs:
    let
      plugins = {

        git = {
          name = "git";
          src = yazi-plugins + "/git.yazi";
        };
        miller = {
          name = "miller";
          src = inputs.miller;
        };

        full-border = {
          name = "full-border";
          src = yazi-plugins + "/full-border.yazi";
        };

        yatline = {
          name = "yatline";
          src = inputs.yatline;
        };
      };
    in
    {
      inherit plugins;
      sources = inputs;
      pluginsList = builtins.attrValues plugins;
    };
}
