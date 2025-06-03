{
  description = "Rhodium | A Hypermodular NixOS System";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05"; # Crucial to lock version here
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # Crucial to lock version here
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR for Firefox extensions
    nur = {
      url = "github:nix-community/NUR";
    };
    # Unofficial Zen Browser Input (Requires unstable)
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };
    # Hyprcursor requirements
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
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
    , hyprland
    , rose-pine-hyprcursor
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          input-fonts.acceptLicense = true; # Required accept license explicitly
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

      # Theme selection logic
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

      # Get user's theme preferences with fallbacks
      userThemeName = userPreferences.theme.name or "chiaroscuro";
      userThemeVariant = userPreferences.theme.variant or "dark";
      selectedTheme = getThemeConfig userThemeName userThemeVariant;

    in
    {
      nixosConfigurations = {
        host_001 = lib.nixosSystem {
          inherit system pkgs;
          modules = [ ./hosts/host_001 ];
          specialArgs = {
            inherit pkgs-unstable inputs rhodiumLib;
            users = userData;
            host = hostData.host_001 or { };
          };
        };

        # host_002 = lib.nixosSystem {
        #   inherit system;
        #   modules = [ ./hosts/host_002 ];
        #   specialArgs = {
        #     inherit pkgs-unstable inputs rhodiumLib;
        #     users = userData;
        #     host = hostData.host_002 or { };
        #   };
        # };
      };

      homeConfigurations = {
        user_001 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/user_001 ];
          extraSpecialArgs = {
            inherit pkgs-unstable inputs rhodiumLib;
            user = userData.user_001 or { };
            theme = selectedTheme;
            inherit userPreferences userExtras;
          };
        };
      };

      devShells.${system} = {
        rhodium-dev = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixpkgs-fmt
            nil
            git
          ];
        };
      };
    };
}
