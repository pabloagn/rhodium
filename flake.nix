{
  description = "Rhodium | A Hypermodular NixOS System";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rhodium-alloys = {
      url = "github:pabloagn/rhodium-alloys";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , sops-nix
    , nur
    , zen-browser
    , rhodium-alloys
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          input-fonts.acceptLicense = true;
        };
        overlays = [
          nur.overlays.default
        ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          nur.overlays.default
        ];
      };

      rhodiumLib = import ./lib { inherit lib pkgs; };

      # Data paths
      dataPath = ./data;
      dataPathUsers = dataPath + "/users/";
      dataPathUserExtras = dataPathUsers + "/extras/";
      dataPathUserPreferences = dataPathUsers + "/preferences/";
      dataPathHosts = dataPath + "/hosts/";

      # Import user data
      userData =
        if builtins.pathExists (dataPathUsers + "/users.nix")
        then (import (dataPathUsers + "/users.nix")).users
        else { };

      # Import user preferences
      userPreferences =
        if builtins.pathExists dataPathUserPreferences
        then (import dataPathUserPreferences)
        else { };

      # Import and pack all user extras data
      userExtras = {

        path = dataPathUserExtras;

        bookmarksData =
          if builtins.pathExists (dataPathUserExtras + "/bookmarks.nix")
          then import (dataPathUserExtras + "/bookmarks.nix")
          else { };
        profilesData =
          if builtins.pathExists (dataPathUserExtras + "/profiles.nix")
          then import (dataPathUserExtras + "/profiles.nix")
          else { };
        appsData =
          if builtins.pathExists (dataPathUserExtras + "/apps.nix")
          then import (dataPathUserExtras + "/apps.nix")
          else { };
      };

      # Import host data
      hostData =
        if builtins.pathExists (dataPathHosts + "/hosts.nix")
        then (import (dataPathHosts + "/hosts.nix")).hosts
        else { };

      # Theme selection
      getThemeConfig = themeName: variant:
        let
          themePath = ./home/assets/themes + "/${themeName}.nix";
          themeConfig =
            if builtins.pathExists themePath
            then import themePath { inherit pkgs; }
            else import ./home/assets/themes/chiaroscuro.nix { inherit pkgs; };
        in
        if variant == "light" && themeConfig.theme ? light
        then themeConfig.theme.light
        else themeConfig.theme.dark;

      # User's theme preferences with fallbacks
      userThemeName = userPreferences.theme.name or "chiaroscuro";
      userThemeVariant = userPreferences.theme.variant or "dark";
      selectedTheme = getThemeConfig userThemeName userThemeVariant;

      # Test Suite
      mkTest = name: path: {
        homeConfiguration = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home.username = "test";
              home.homeDirectory = "/tmp/test-home";
              home.stateVersion = "25.05";
              imports = [ path ];
            }
          ];
          extraSpecialArgs = {
            inherit pkgs-unstable inputs rhodiumLib userData;
            user = userData.user_001 or { };
            host = { };
            theme = selectedTheme;
            inherit userPreferences userExtras;
            fishPlugins = rhodium-alloys.fish;
            yaziPlugins = rhodium-alloys.yazi;
          };
        };
        
        shell = pkgs.mkShell {
          shellHook = ''
            export HOME=$(mktemp -d)
            export RHODIUM_TEST_ENV="${name}"
            export STARSHIP_CONFIG_TEST="true"
            home-manager switch --flake .#test-${name} --impure
            echo "🧪 Testing ${name} environment"
            echo "✅ Run: ${name}"
          '';
        };
      };

      testConfigs = {
        neovim = mkTest "nvim" ./home/apps/editors/nvim;
        tmux = mkTest "tmux" ./home/apps/terminals/utils/tmux;
        fish = mkTest "fish" ./home/shells/fish;
      };

    in
    {
      nixosConfigurations = {

        # Host Entry
        host_001 = lib.nixosSystem {
          inherit system pkgs;
          modules = [ 
            ./hosts/host_001 
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                
                users.${userData.user_001.username or "user_001"} = import ./users/user_001;
                
                extraSpecialArgs = {
                  inherit pkgs-unstable inputs rhodiumLib userData;
                  user = userData.user_001 or { };
                  host = hostData.host_001 or { };
                  theme = selectedTheme;
                  inherit userPreferences userExtras;
                  fishPlugins = rhodium-alloys.fish;
                  yaziPlugins = rhodium-alloys.yazi;
                };
              };
            }
          ];
          specialArgs = {
            inherit pkgs-unstable inputs rhodiumLib;
            users = userData;
            host = hostData.host_001 or { };
          };
        };

        # Host Entry
        host_002 = lib.nixosSystem {
          inherit system pkgs;
          modules = [ 
            ./hosts/host_002 
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                
                users.${userData.user_001.username or "user_001"} = import ./users/user_001;
                
                extraSpecialArgs = {
                  inherit pkgs-unstable inputs rhodiumLib userData;
                  user = userData.user_001 or { };
                  host = hostData.host_002 or { };
                  theme = selectedTheme;
                  inherit userPreferences userExtras;
                  fishPlugins = rhodium-alloys.fish;
                  yaziPlugins = rhodium-alloys.yazi;
                };
              };
            }
          ];
          specialArgs = {
            inherit pkgs-unstable inputs rhodiumLib;
            users = userData;
            host = hostData.host_002 or { };
          };
        };
      };
      # Standalone home configurations (testing)
     homeConfigurations = {
       user_001 = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         modules = [ ./users/user_001 ];
         extraSpecialArgs = {
           inherit pkgs-unstable inputs rhodiumLib userData;
           user = userData.user_001 or { };
           host = { };
           theme = selectedTheme;
           inherit userPreferences userExtras;
           fishPlugins = rhodium-alloys.fish;
           yaziPlugins = rhodium-alloys.yazi;
         };
       };
     } // (builtins.mapAttrs (name: config: config.homeConfiguration) testConfigs);

     # Devshells
     # ---------------------------------------------
     devShells.${system} = {
       # Default DevShell
       default = pkgs.mkShell {
         buildInputs = with pkgs; [
           nixpkgs-fmt
           nil
           git
         ];
       };
       # Rhodium Dev DevShell
       rhodium-dev = pkgs.mkShell {
         buildInputs = with pkgs; [
           nixpkgs-fmt
           nil
           git
         ];
       };
     } // (builtins.mapAttrs (name: config: config.shell) testConfigs);
   };
}
