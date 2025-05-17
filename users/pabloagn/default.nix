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

      notifications = {
        dunst.enable = true;
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
        rstudio.enable = false;
        vscode.enable = true;
        vscodium.enable = false;
        cursor.enable = true;
        kate.enable = true;
      };

      databases = {
        enable = true;
      };

      tools = {
        enable = true;

        ollama.enable = false;
        postman.enable = false;
      };

      virtualization = {
        enable = true;

        containers = {
          enable = true;
          docker.enable = true;
          podman.enable = false;
          kubernetes.enable = false;
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

    # Applications
    apps = {
      enable = true;

      communication = {
        enable = true;

        messaging = {
          enable = true;
        };

        email = {
          enable = true;
        };
      };

      browsers = {
        enable = true;

        firefox = {
          enable = true;

          variant = "devedition";
        };
        brave.enable = false;
        chrome.enable = false;
        chromium.enable = false;
        librewolf.enable = false;
        qutebrowser.enable = false;
        tor.enable = false;
        w3m.enable = false;
        zen.enable = true;
      };

      documents = {
        enable = true;
      };

      media = {
        enable = true;
      };

      terminals = {
        enable = true;

        foot.enable = false;
        ghostty.enable = true;
        kitty.enable = true;
        st.enable = false;
        wezterm.enable = true;
      };

      utilities = {
        enable = true;

        notes = {
          enable = true;
        };

        calendars = {
          enable = true;
        };

        calculators = {
          enable = true;
        };
      };
    };

    security = {
      enable = true;

      auth = {
        enable = true;
      };

      opsec = {
        enable = true;
      };

      privacy = {
        enable = true;
      };
    };

    system = {
      enable = true;
    };
  };

  # State
  # ------------------------------------
  home.stateVersion = "24.11";
}
