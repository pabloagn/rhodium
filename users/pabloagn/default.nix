# users/pabloagn/default.nix

{ inputs, pkgs, lib, config, flakeOutputs, self, ... }:

{
  imports = [
    flakeOutputs.rhodium.home.default
  ];

  # Profile
  # ------------------------------------
  home.username = "pabloagn";
  home.homeDirectory = "/home/pabloagn";

  # Options
  # ------------------------------------
  rhodium = {

    environment = {
      enable = true;
      variables.enable = true;
      mime.enable = true;
      paths.enable = true;
    };

    desktop = {
      wm.hyprland = {
        enable = true;
        hyprpaper.enable = true;
      };

      launcher = {
        rofi.enable = true;
        fuzzel.enable = true;
      };

      bar = {
        waybar.enable = true;
      };

      applications = {
        enable = true;
      };
    };

    shell = {
      enable = true;

      shells = {
        zsh = {
          enable = true;
          defaultShell = true;
          enableSyntaxHighlighting = true;
          enableAutosuggestions = true;
          enableCompletion = true;
        };

        bash = {
          enable = true;
          enableCompletion = true;
        };
      };

      prompts = {
        starship = {
          enable = true;
        };
      };
    };

    development = {
      enable = true;
      editors = {
        enable = true;
        helix.enable = true;
        nvim.enable = true;
        mousepad.enable = true;
      };

      databases = {
        enable = true;
      };

      tools = {
        enable = true;
      };

      virtualization = {
        enable = true;
        containers = {
          enable = true;
        };
      };

      # Programming Languages
      enabledLanguages = [
        "nix"
        "rust"
        "go"
        "python"
        "c"
        "cpp"
        # Examples with options (more granular control):
        # { name = "rust"; version = "stable"; }
        # { name = "go"; version = "1.18"; installTools = true; }
      ];
    };

    security = {
      auth = {
        enable = true;
      };
    };
  };

  # State
  # ------------------------------------
  home.stateVersion = "24.11";
}
