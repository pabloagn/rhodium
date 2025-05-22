# home/profiles/developer.nix

{ config, lib, rhodium, pkgs, ... }:

{
  rhodium.home.environment = {
    enable = true;
    preferredApps = {
      browser = "firefox";
      editor = "helix";
      terminal = "ghostty";
      imageViewer = "feh";
      videoPlayer = "mpv";
      audioPlayer = "clementine";
      pdfViewer = "zathura";
      wm = "hyprland";
    };
  };

  rhodium.home.apps = {
    enable = true;

    browsers = {
      enable = true;
      firefox = {
        enable = true;
        variant = "devedition";
      };
    };

    communication = {
      enable = true;
      email = {
        enable = true;
        thunderbird.enable = true;
        protonmail.enable = true;
      };

      messaging = {
        enable = true;
        teams.enable = true;
        zoom.enable = true;
        whatsapp.enable = true;
        slack.enable = true;
        signal.enable = true;
      };
    };

    desktop = {
      enable = true;
    };

    documents = {
      enable = true;
      libreoffice.enable = true;
      onlyoffice.enable = true;
      okular.enable = true;
      zathura.enable = true;
      texmaker.enable = true;
    };

    files = {
      enable = true;
      thunar.enable = true;
    };

    media = {
      enable = true;
      audio = {
        enable = true;
        clementine.enable = true;
        spotify.enable = true;
      };
      image = {
        enable = true;
        feh.enable = true;
      };
      torrent = {
        enable = true;
        deluge.enable = true;
      };
      video = {
        enable = true;
        mpv.enable = true;
        vlc.enable = true;
        plex.enable = true;
        obs-studio.enable = true;
        handbrake.enable = true;
        yt-dlp.enable = true;
      };
    };

    privacy = {
      enable = true;
      protonvpn-cli.enable = true;
      protonvpn-gui.enable = true;
      wireguard-tools.enable = true;
      mat2.enable = true;
    };

    terminal = {
      enable = true;

      emulators = {
        enable = true;
        kitty.enable = true;
        ghostty.enable = true;
      };

      utils = {
        enable = true;
        compression.enable = true;
        development.enable = true;
        multiplexers.enable = true;
        navigation.enable = true;
        networking.enable = true;
        processing.enable = true;
        productivity.enable = true;
        system.enable = true;
      };
    };
    utils = {
      enable = true;
      notes = {
        enable = true;
        obsidian.enable = true;
      };
      calculators.enable = true;
    };
  };

  rhodium.home.development = {
    enable = true;
    editors = {
      enable = true;
      nvim = {
        enable = true;
        desktop = {
          enable = true;
          withName = "nvim-pablo-ide";
          withDesktopName = "Neovim (Pablo's IDE)";
          withGenericName = "Advanced Text Editor";
          withExec = "${config.home.sessionVariables.TERMINAL} --title 'Rhodium's Neovim IDE' -e nvim %F";
          withIcon = "neovim";
          withComment = "Pablo's customized Neovim development environment";
          withCategories = [ "Development" "IDE" "TextEditor" "Utility" ];
          withTerminal = true;
          withMimeTypes = [ "text/plain" "text/x-script" "application/x-nix" ];
        };
      };

      helix = {
        enable = true;
        desktop = {
          enable = true;
          withName = "helix-instance";
          withDesktopName = "Helix";
          withGenericName = "Advanced Text Editor";
          withExec = "${config.home.sessionVariables.TERMINAL} --title 'Rhodium's Helix IDE' -e hx %F";
          withIcon = "helix";
          withComment = "Pablo's customized Helix development environment";
          withCategories = [ "Development" "IDE" "TextEditor" "Utility" ];
          withTerminal = true;
          withMimeTypes = [ "text/plain" "text/x-script" "application/x-nix" ];
        };
      };
    };
  };
}
