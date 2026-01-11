{ ... }:
{
  icon = {
    prepend_globs = [
      {
        url = "*/*.rh/";
        text = "󰊕";
        fg = "#BF3F42";
      }
    ];

    # --- Entire Filenames ---
    prepend_files = [
      {
        name = "justfile";
        text = "󱓞";
        fg = "#6B7E84";
      }
      {
        name = ".env.example";
        text = "";
        fg = "#6B7E84";
      }
    ];
    prepend_dirs = [
      # --- Rhodium System ---
      # Main Rhodium Dir
      {
        name = "rhodium";
        text = "λ";
        fg = "#BF3F42";
      }
      # Rhodium Modules
      {
        name = "*.rh";
        text = "󰊕";
        fg = "#BF3F42";
      }
      # {
      #   name = "chiaroscuro.rh";
      #   text = "󰊕";
      #   fg = "#BF3F42";
      # }
      # {
      #   name = "iridium.rh";
      #   text = "󰊕";
      #   fg = "#BF3F42";
      # }
      # {
      #   name = "palladium.rh";
      #   text = "󰊕";
      #   fg = "#BF3F42";
      # }

      # --- Projects ---
      {
        name = "kronos";
        text = "󰏉";
        fg = "#BF3F42";
      }
      {
        name = "phantom";
        text = "†";
        fg = "#BF3F42";
      }
      {
        name = "personal-website";
        text = "ψ";
        fg = "#BF3F42";
      }
      # --- Home Directories ---
      {
        name = "downloads";
        text = "";
        fg = "#88A1AC";
      }
      {
        name = "pendings";
        text = "";
        fg = "#88A1AC";
      }
      {
        name = "pictures";
        text = "󰄄";
        fg = "#88A1AC";
      }
      {
        name = "professional";
        text = "";
        fg = "#88A1AC";
      }
      {
        name = "solenoid-labs";
        text = "󱒀";
        fg = "#88A1AC";
      }
      {
        name = "dev";
        text = "";
        fg = "#88A1AC";
      }
      {
        name = "vaults";
        text = "󰴓";
        fg = "#88A1AC";
      }
      {
        name = "academic";
        text = "󰂺";
        fg = "#88A1AC";
      }
      {
        name = "documents";
        text = "󰈙";
        fg = "#88A1AC";
      }
      {
        name = ".config";
        text = "";
        fg = "#88A1AC";
      }
      {
        name = ".local";
        text = "";
        fg = "#88A1AC";
      }
    ];
    prepend_exts = [
      {
        name = "j2";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "jinja";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "jinja2";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "yuck";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "backup";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "bkp";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "bak";
        text = "󰒓";
        fg = "#6B7E84";
      }
      # Haskell
      {
        name = "cabal";
        text = "";
        fg = "#9D72C0";
      }
      # --- Rhodium Config Files ---
      {
        name = "rh";
        text = "󰘧";
        fg = "#BF3F42";
      }
      # --- Text Files ---
      {
        name = "txt";
        text = "󰈙";
        fg = "#597b75";
      }
      {
        name = "rtf";
        text = "󰈙";
        fg = "#597b75";
      }
      {
        name = "rst";
        text = "󰈙";
        fg = "#597b75";
      }
      {
        name = "g";
        text = "󰿉";
        fg = "#C1C5C3";
      }
      {
        name = "cl";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "idr";
        text = "󰊕";
        fg = "#C1C5C3";
      }
      {
        name = "nb";
        text = "󱂅";
        fg = "#C1C5C3";
      }
      {
        name = "thy";
        text = "󰬛";
        fg = "#C1C5C3";
      }
      {
        name = "glsl";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "hlsl";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "metal";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "wgsl";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "cir";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "chpl";
        text = "󰬊";
        fg = "#C1C5C3";
      }
      {
        name = "stan";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "sage";
        text = "󰬚";
        fg = "#C1C5C3";
      }
      {
        name = "mac";
        text = "󰬔";
        fg = "#C1C5C3";
      }
      {
        name = "pas";
        text = "󰬗";
        fg = "#C1C5C3";
      }
      {
        name = "kdl";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "sty";
        text = "";
        fg = "#87a987";
      }
      {
        name = "cls";
        text = "";
        fg = "#87a987";
      }
      {
        name = "tex";
        text = "";
        fg = "#87a987";
      }
      {
        name = "lisp";
        text = "";
        fg = "#C1C5C3";
      }
      {
        name = "nix";
        text = "";
        fg = "#2D4F67";
      }
      {
        name = "nix-channels";
        text = "";
        fg = "#2D4F67";
      }
      {
        name = "ts";
        text = "";
        fg = "#2D4F67";
      }
      {
        name = "yaml";
        text = "";
        fg = "#43436c";
      }
      {
        name = "yml";
        text = "";
        fg = "#43436c";
      }
      {
        name = "conf";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "cnf";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "config";
        text = "󰒓";
        fg = "#6B7E84";
      }
      {
        name = "hcl";
        text = "";
        fg = "#6B7E84";
      }
      {
        name = "topojson";
        text = "";
        fg = "#597b75";
      }
      {
        name = "geojson";
        text = "";
        fg = "#597b75";
      }
      {
        name = "parquet";
        text = "";
        fg = "#597b75";
      }
      {
        name = "tsv";
        text = "";
        fg = "#597b75";
      }
      {
        name = "csv";
        text = "";
        fg = "#597b75";
      }
      {
        name = "cbor";
        text = "";
        fg = "#597b75";
      }
      {
        name = "fasta";
        text = "";
        fg = "#597b75";
      }
      {
        name = "gff";
        text = "";
        fg = "#597b75";
      }
      {
        name = "fastq";
        text = "";
        fg = "#597b75";
      }
      {
        name = "feather";
        text = "󰛓";
        fg = "#597b75";
      }
      {
        name = "cbor";
        text = "";
        fg = "#597b75";
      }
      {
        name = "msgpack";
        text = "";
        fg = "#597b75";
      }
      {
        name = "proto";
        text = "";
        fg = "#4b4e57";
      }
      {
        name = "fbs";
        text = "";
        fg = "#4b4e57";
      }
      {
        name = "bfbs";
        text = "";
        fg = "#4b4e57";
      }
      {
        name = "capnp";
        text = "";
        fg = "#4b4e57";
      }
      {
        name = "pkl";
        text = "";
        fg = "#597b75";
      }
      {
        name = "pickle";
        text = "";
        fg = "#597b75";
      }
    ];
  };
  mgr = {
    marker_copied = {
      fg = "#87A987";
      bg = "#87A987";
    };
    marker_cut = {
      fg = "#E46876";
      bg = "#E46876";
    };
    marker_marked = {
      fg = "#938AA9";
      bg = "#938AA9";
    };
    marker_selected = {
      fg = "#B98D7B";
      bg = "#B98D7B";
    };
    cwd = {
      fg = "#E6C384";
    };
    find_keyword = {
      fg = "#B98D7B";
      bg = "#090E13";
    };
    find_position = { };
    count_copied = {
      fg = "#090E13";
      bg = "#87A987";
    };
    count_cut = {
      fg = "#090E13";
      bg = "#E46876";
    };
    count_selected = {
      fg = "#090E13";
      bg = "#E6C384";
    };
    border_symbol = "│";
    border_style = {
      fg = "#C5C9C7";
    };
  };

  # Tab bar styling - clean black/white with no rounded corners
  tabs = {
    active = {
      fg = "#090E13";
      bg = "#C5C9C7";
      bold = true;
    };
    inactive = {
      fg = "#6B7E84";
      bg = "#090E13";
    };
    # Square separators - no rounded corners
    sep_inner = {
      open = " ";
      close = " ";
    };
    sep_outer = {
      open = "";
      close = "";
    };
  };

  mode = {
    normal_main = {
      fg = "#090E13";
      bg = "#8BA4B0";
    };
    normal_alt = {
      fg = "#8BA4B0";
      bg = "#090E13";
    };
    select_main = {
      fg = "#090e13";
      bg = "#957fb8";
    };
    select_alt = {
      fg = "#957fb8";
      bg = "#090e13";
    };
    unset_main = {
      fg = "#090E13";
      bg = "#e6c384";
    };
    unset_alt = {
      fg = "#e6c384";
      bg = "#090E13";
    };
  };

  status = {
    sep_left = {
      open = "";
      close = "";
    };
    sep_right = {
      open = "";
      close = "";
    };
    overall = {
      fg = "#C5C9C7";
      bg = "#090e13";
    };
    progress_label = {
      fg = "#8BA4B0";
      bg = "#090E13";
      bold = true;
    };
    progress_normal = {
      fg = "#090E13";
      bg = "#090E13";
    };
    progress_error = {
      fg = "#090E13";
      bg = "#090E13";
    };
    perm_type = {
      fg = "#87A987";
    };
    perm_read = {
      fg = "#E6C384";
    };
    perm_write = {
      fg = "#E46876";
    };
    perm_exec = {
      fg = "#7AA89F";
    };
    perm_sep = {
      fg = "#938AA9";
    };
  };

  pick = {
    border = {
      fg = "#7fb4ca";
    };
    active = {
      fg = "#938AA9";
      bold = true;
    };
    inactive = { };
  };

  input = {
    border = {
      fg = "#7fb4ca";
    };
    title = { };
    value = { };
    selected = {
      reversed = true;
    };
  };

  completion = {
    border = {
      fg = "#7fb4ca";
    };
    active = {
      reversed = true;
    };
    inactive = { };
  };

  tasks = {
    border = {
      fg = "#7fb4ca";
    };
    title = { };
    hovered = {
      fg = "#938AA9";
    };
  };

  which = {
    cols = 2;
    separator = " - ";
    separator_style = {
      fg = "#A4A7A4";
    };
    mask = {
      bg = "#090e13";
    };
    rest = {
      fg = "#A4A7A4";
    };
    cand = {
      fg = "#8EA4A2";
    };
    desc = {
      fg = "#C5C9C7";
    };
  };

  help = {
    on = {
      fg = "#7AA89F";
    };
    run = {
      fg = "#938AA9";
    };
    desc = { };
    hovered = {
      reversed = true;
      bold = true;
    };
    footer = {
      fg = "#090e13";
      bg = "#C5C9C7";
    };
  };

  notify = {
    title_info = {
      fg = "#87A987";
    };
    title_warn = {
      fg = "#E6C384";
    };
    title_error = {
      fg = "#E46876";
    };
  };

  indicator = {
    # Square corners instead of rounded
    padding = {
      open = "█";
      close = "█";
    };
    current = {
      reversed = true;
    };
    preview = {
      reversed = true;
    };
  };

  filetype = {
    rules = [
      # images
      {
        mime = "image/*";
        fg = "#E6C384";
      }
      # media
      {
        mime = "{audio,video}/*";
        fg = "#938AA9";
      }
      # archives
      {
        mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
        fg = "#e46876";
      }
      # documents
      {
        mime = "application/{pdf,doc,rtf,vnd.*}";
        fg = "#A292A3";
      }
      # broken links
      {
        name = "*";
        is = "orphan";
        fg = "#E46876";
      }
      # executables
      {
        name = "*";
        is = "exec";
        fg = "#7AA89F";
      }
      # fallback
      {
        name = "*";
        fg = "#C5C9C7";
      }
      {
        name = "*/";
        fg = "#8BA4B0";
      }
    ];
  };
}
