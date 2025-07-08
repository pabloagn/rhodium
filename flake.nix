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

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanso-nvim = {
      url = "github:pabloagn/kanso.nvim"; # NOTE: Personal fork
      flake = false;
    };

    chiaroscuro = {
      url = "github:pabloagn/chiaroscuro.rht";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rhodium-alloys = {
      url = "github:pabloagn/alloys.rhf";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    iridium-rh = {
      url = "git+ssh://git@github.com/pabloagn/iridium.rh.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    flake-parts,
    sops-nix,
    nur,
    ags,
    zen-browser,
    kanso-nvim,
    chiaroscuro,
    rhodium-alloys,
    iridium-rh,
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    # Import overlays with inputs
    overlaysWithInputs = import ./overlays {inherit inputs;};

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
        permittedInsecurePackages = [
          "jitsi-meet-1.0.8043"
        ];
      };
      overlays = [
        nur.overlays.default
        overlaysWithInputs.fonts
      ];
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        nur.overlays.default
        overlaysWithInputs.fonts
      ];
    };

    rhodiumLib = import ./lib {inherit lib pkgs;};

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
      else {};

    # Import user preferences
    userPreferences =
      if builtins.pathExists dataPathUserPreferences
      then (import dataPathUserPreferences)
      else {};

    # Import and pack all user extras data
    userExtras = {
      path = dataPathUserExtras;

      bookmarksData =
        if builtins.pathExists (dataPathUserExtras + "/bookmarks.nix")
        then import (dataPathUserExtras + "/bookmarks.nix")
        else {};

      profilesData =
        if builtins.pathExists (dataPathUserExtras + "/profiles.nix")
        then import (dataPathUserExtras + "/profiles.nix")
        else {};

      appsData =
        if builtins.pathExists (dataPathUserExtras + "/apps.nix")
        then import (dataPathUserExtras + "/apps.nix")
        else {};
    };

    # Import host data
    hostData =
      if builtins.pathExists (dataPathHosts + "/hosts.nix")
      then (import (dataPathHosts + "/hosts.nix")).hosts
      else {};

    # Theme selection
    getThemeConfig = themeName: variant: let
      themePath = ./home/assets/themes + "/${themeName}.nix";
      themeConfig =
        if builtins.pathExists themePath
        then import themePath {inherit pkgs;}
        else import ./home/assets/themes/chiaroscuro.nix {inherit pkgs;};
    in
      if variant == "light" && themeConfig.theme ? light
      then themeConfig.theme.light
      else themeConfig.theme.dark;

    # User's theme preferences with fallbacks
    userThemeName = userPreferences.theme.name or "chiaroscuro";
    userThemeVariant = userPreferences.theme.variant or "dark";
    selectedTheme = getThemeConfig userThemeName userThemeVariant;

    # TODO: Temporary theme imports
    # While we have the complete theme module set up
    targetTheme = import ./home/modules/themes.nix {inherit pkgs inputs;};

    chiaroscuroTheme = inputs.chiaroscuro.themes.kanso-zen;
  in {
    overlays = import ./overlays;

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
              backupFileExtension = "backup";

              users.${userData.user_001.username or "user_001"} = import ./users/user_001;

              extraSpecialArgs = {
                inherit pkgs-unstable inputs rhodiumLib userData;
                user = userData.user_001 or {};
                host = hostData.host_001 or {};
                theme = selectedTheme;
                targetTheme = targetTheme; # TODO: This is temporary
                chiaroscuroTheme = chiaroscuroTheme; # TODO: This is temporary
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
          host = hostData.host_001 or {};
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
              backupFileExtension = "backup";

              users.${userData.user_001.username or "user_001"} = import ./users/user_001;

              extraSpecialArgs = {
                inherit pkgs-unstable inputs rhodiumLib userData;
                user = userData.user_001 or {};
                host = hostData.host_002 or {};
                theme = selectedTheme;
                targetTheme = targetTheme; # TODO: This is temporary
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
          host = hostData.host_002 or {};
        };
      };
    };

    # Standalone home configurations (testing)
    homeConfigurations = {
      user_001 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./users/user_001];
        extraSpecialArgs = {
          inherit pkgs-unstable inputs rhodiumLib userData;
          user = userData.user_001 or {};
          host = {};
          theme = selectedTheme;
          targetTheme = targetTheme; # TODO: This is temporary
          inherit userPreferences userExtras;
          fishPlugins = rhodium-alloys.fish;
          yaziPlugins = rhodium-alloys.yazi;
        };
      };
    };

    # devShells
    # ---------------------------------------------
    devShells.${system} = {
      # Default DevShell
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # General requirements
          nixpkgs-fmt
          nixd
          nil
          git
          ripgrep
          sd
          fd
          pv
          fzf
          bat
          hyperfine
          # Requirements for cache building
          python3
          python3Packages.wcwidth
        ];
      };
    };
  };
}
