# home/development/editors/helix/editor.nix

{ config, lib }:

with lib;
let
  # Default editor settings
  defaultSettings = {
    line-number = "relative";
    mouse = true;
    default-yank-register = "+";
    middle-click-paste = true;
    scroll-lines = 1;
    scrolloff = 8;
    cursorline = true;
    cursorcolumn = false;
    auto-completion = true;
    auto-format = true;
    auto-info = true;
    idle-timeout = 250;
    completion-trigger-len = 1;
    bufferline = "always";
    insert-final-newline = true;
    popup-border = "all";
    indent-heuristic = "hybrid";
  };

  # Cursor shape configurations
  cursorShapes = {
    default = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    classic = {
      insert = "block";
      normal = "block";
      select = "block";
    };

    modern = {
      insert = "bar";
      normal = "hollow";
      select = "underline";
    };
  };

  # File picker configurations
  filePickerConfigs = {
    developer = {
      hidden = true;
      git-ignore = true;
      follow-symlinks = true;
    };

    writer = {
      hidden = false;
      git-ignore = false;
      follow-symlinks = true;
    };
  };

  # Indent guide configurations
  indentGuides = {
    minimal = {
      render = false;
    };

    standard = {
      render = true;
      character = "▏";
    };

    detailed = {
      render = true;
      character = "│";
      skip-levels = 1;
    };
  };

  # Statusline configurations
  statuslineConfigs = {
    full = {
      separator = " │ ";

      mode = {
        normal = " NORMAL ";
        insert = " INSERT ";
        select = " SELECT ";
      };

      left = [
        "mode"
        "spinner"
        "file-absolute-path"
        "read-only-indicator"
        "file-modification-indicator"
      ];

      center = [
        "version-control"
      ];

      right = [
        "diagnostics"
        "workspace-diagnostics"
        "spacer"
        "selections"
        "spacer"
        "position"
        "position-percentage"
        "total-line-numbers"
        "spacer"
        "file-encoding"
        "file-line-ending"
        "file-type"
      ];
    };

    minimal = {
      separator = " | ";

      mode = {
        normal = "N";
        insert = "I";
        select = "S";
      };

      left = [
        "mode"
        "file-name"
        "file-modification-indicator"
      ];

      center = [ ];

      right = [
        "position"
        "file-type"
      ];
    };

    writer = {
      separator = " • ";

      mode = {
        normal = "EDIT";
        insert = "WRITE";
        select = "SELECT";
      };

      left = [
        "mode"
        "file-name"
        "file-modification-indicator"
      ];

      center = [
        "version-control"
      ];

      right = [
        "position"
        "total-line-numbers"
        "file-type"
      ];
    };
  };

  # Smart tab configurations
  smartTabConfigs = {
    standard = {
      enable = true;
      supersede-menu = false;
    };

    aggressive = {
      enable = true;
      supersede-menu = true;
    };
  };

  # Whitespace rendering configurations
  whitespaceConfigs = {
    none = {
      render = {
        space = "none";
        tab = "none";
        newline = "none";
      };
    };

    minimal = {
      render = {
        space = "none";
        tab = "all";
        newline = "none";
      };
      characters = {
        tab = "→";
      };
    };

    detailed = {
      render = {
        space = "all";
        tab = "all";
        newline = "all";
      };
      characters = {
        tab = "→";
        space = "·";
        newline = "⏎";
      };
    };
  };

in
{
  # Main editor configuration builder
  mkEditorConfig =
    { profile ? "standard"
    , clipboardProvider ? "wl-clipboard"
    , cursorShape ? "default"
    , filePicker ? "developer"
    , indentGuide ? "standard"
    , statusline ? "full"
    , smartTab ? "standard"
    , whitespace ? "none"
    , overrides ? { }
    ,
    }:
    let
      baseConfig = defaultSettings // {
        clipboard-provider = clipboardProvider;
        cursor-shape = cursorShapes.${cursorShape};
        file-picker = filePickerConfigs.${filePicker};
        indent-guides = indentGuides.${indentGuide};
        statusline = statuslineConfigs.${statusline};
        smart-tab = smartTabConfigs.${smartTab};
      } // (optionalAttrs (whitespace != "none") {
        whitespace = whitespaceConfigs.${whitespace};
      });
    in
    recursiveUpdate baseConfig overrides;

  # Export individual configuration sets for fine-grained control
  inherit cursorShapes filePickerConfigs indentGuides statuslineConfigs smartTabConfigs whitespaceConfigs;

  # Pre-built editor profiles
  profiles = {
    # Standard development setup
    developer = {
      profile = "standard";
      statusline = "full";
      indentGuide = "standard";
      smartTab = "standard";
    };

    # Minimal setup for quick edits
    minimal = {
      profile = "minimal";
      statusline = "minimal";
      indentGuide = "minimal";
      smartTab = "standard";
      overrides = {
        auto-completion = false;
        bufferline = "never";
        popup-border = "none";
      };
    };

    # Writing-focused setup
    writer = {
      profile = "writer";
      statusline = "writer";
      indentGuide = "minimal";
      filePicker = "writer";
      overrides = {
        soft-wrap.enable = true;
        rulers = [ 80 ];
        completion-trigger-len = 3;
      };
    };
  };
}
