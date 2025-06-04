{
  description = "Rhodium | Fish Plugins Collection";
  
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05"; # Crucial to lock version here
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
    fasd = {
      url = "github:oh-my-fish/plugin-fasd";
      flake = false;
    };
    # Add more plugins here as needed
    # autopair = {
    #   url = "github:jorgebucaran/autopair.fish";
    #   flake = false;
    # };
  };
  
  outputs = {
    self
    , nixpkgs
    , colored-man
    , z
    , fasd
  }@inputs:
  {
    plugins = {
      colored-man = {
        name = "colored-man";
        src = colored-man;
      };

      z = {
        name = "z";
        src = z;
      };

      fasd = {
        name = "fasd";
        src = fasd;
      };
    };
    
    sources = {
      inherit colored-man z fasd;
    };
    
    # Helper function to get all plugins as a list
    pluginsList = builtins.attrValues self.plugins;
  };
}
