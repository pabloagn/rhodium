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

    # Archive Management
    archivemount = {
      url = "github:AnirudhG07/archivemount.yazi";
      flake = false;
    };

    compress = {
      url = "github:KKV9/compress.yazi";
      flake = false;
    };

    fuse-archive = {
      url = "github:dawsers/fuse-archive.yazi";
      flake = false;
    };

    ouch = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
    };

    # Clipboard Management
    copy-file-contents = {
      url = "github:AnirudhG07/plugins-yazi";
      flake = false;
    };

    save-clipboard-to-file = {
      url = "github:boydaihungst/save-clipboard-to-file.yazi";
      flake = false;
    };

    system-clipboard = {
      url = "github:orhnk/system-clipboard.yazi";
      flake = false;
    };

    wl-clipboard = {
      url = "github:grappas/wl-clipboard.yazi";
      flake = false;
    };

    # File Management
    augment-command = {
      url = "github:hankertrix/augment-command.yazi";
      flake = false;
    };

    bypass = {
      url = "github:Rolv-Apneseth/bypass.yazi";
      flake = false;
    };

    file-actions = {
      url = "github:BBOOXX/file-actions.yazi";
      flake = false;
    };

    reflink = {
      url = "github:Ape/reflink.yazi";
      flake = false;
    };

    smart-filter = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    sudo = {
      url = "github:TD-Sky/sudo.yazi";
      flake = false;
    };

    # Git Integration
    git = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    githead = {
      url = "github:llanosrocas/githead.yazi";
      flake = false;
    };

    lazygit = {
      url = "github:Lil-Dank/lazygit.yazi";
      flake = false;
    };

    vcs-files = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    # Image and Media Viewers
    allmytoes = {
      url = "github:Sonico98/allmytoes.yazi";
      flake = false;
    };

    sxiv = {
      url = "github:NoponyAsked/sxiv.yazi";
      flake = false;
    };

    # MIME and File Type
    mime-ext = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    # mime-ext-dreammaomao = {
    #   url = "gitee:DreamMaoMao/mime-ext.yazi";
    #   flake = false;
    # };

    # mime-preview = {
    #   url = "gitee:DreamMaoMao/mime-preview.yazi";
    #   flake = false;
    # };

    # Navigation and Bookmarks
    bunny = {
      url = "github:stelcodes/bunny.yazi";
      flake = false;
    };

    # easyjump = {
    #   url = "gitee:DreamMaoMao/easyjump.yazi";
    #   flake = false;
    # };

    # fg = {
    #   url = "gitee:DreamMaoMao/fg.yazi";
    #   flake = false;
    # };

    projects = {
      url = "github:MasouShizuka/projects.yazi";
      flake = false;
    };

    # Previews
    # epub = {
    #   url = "gitee:DreamMaoMao/epub.yazi";
    #   flake = false;
    # };

    eza-preview = {
      url = "github:ahkohd/eza-preview.yazi";
      flake = false;
    };

    glow = {
      url = "github:Reledia/glow.yazi";
      flake = false;
    };

    hexyl = {
      url = "github:Reledia/hexyl.yazi";
      flake = false;
    };

    mdcat = {
      url = "github:GrzegorzKozub/mdcat.yazi";
      flake = false;
    };

    miller = {
      url = "github:Reledia/miller.yazi";
      flake = false;
    };

    nbpreview = {
      url = "github:AnirudhG07/nbpreview.yazi";
      flake = false;
    };

    office = {
      url = "github:macydnah/office.yazi";
      flake = false;
    };

    piper = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    torrent-preview = {
      url = "github:kirasok/torrent-preview.yazi";
      flake = false;
    };

    # Shell Integration
    command = {
      url = "github:KKV9/command.yazi";
      flake = false;
    };

    custom-shell = {
      url = "github:AnirudhG07/custom-shell.yazi";
      flake = false;
    };

    nu = {
      url = "github:Tyarel8/nu.yazi";
      flake = false;
    };

    # Smart Enter
    smart-enter = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    # Themes
    crystal = {
      url = "github:sachinsenal0x64/crystal.yazi";
      flake = false;
    };

    flexoki = {
      url = "github:Reledia/flexoki.yazi";
      flake = false;
    };

    ls-colors = {
      url = "github:Mellbourn/ls-colors.yazi";
      flake = false;
    };

    rose-pine = {
      url = "github:Msouza91/rose-pine.yazi";
      flake = false;
    };

    tokyonight-night = {
      url = "github:kalidyasin/yazi-flavors";
      flake = false;
    };

    # UI Enhancements
    auto-layout = {
      url = "github:josephschmitt/auto-layout.yazi";
      flake = false;
    };

    dual-pane = {
      url = "github:dawsers/dual-pane.yazi";
      flake = false;
    };

    file-extra-metadata = {
      url = "github:boydaihungst/file-extra-metadata.yazi";
      flake = false;
    };

    full-border = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    starship = {
      url = "github:Rolv-Apneseth/starship.yazi";
      flake = false;
    };

    toggle-pane = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    yatline = {
      url = "github:imsi32/yatline.yazi";
      flake = false;
    };

    yatline-symlink = {
      url = "github:lpanebr/yazi-plugins";
      flake = false;
    };

    # Utilities
    chmod = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    diff = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, yazi-plugins, ... }@inputs:
    let
      plugins = {

        # Archive Management
        archivemount = {
          name = "archivemount";
          src = inputs.archivemount;
        };

        compress = {
          name = "compress";
          src = inputs.compress;
        };

        fuse-archive = {
          name = "fuse-archive";
          src = inputs.fuse-archive;
        };

        ouch = {
          name = "ouch";
          src = inputs.ouch;
        };

        # Clipboard Management
        copy-file-contents = {
          name = "copy-file-contents";
          src = inputs.copy-file-contents + "/copy-file-contents.yazi";
        };

        save-clipboard-to-file = {
          name = "save-clipboard-to-file";
          src = inputs.save-clipboard-to-file;
        };

        system-clipboard = {
          name = "system-clipboard";
          src = inputs.system-clipboard;
        };

        wl-clipboard = {
          name = "wl-clipboard";
          src = inputs.wl-clipboard;
        };

        # File Management
        augment-command = {
          name = "augment-command";
          src = inputs.augment-command;
        };

        bypass = {
          name = "bypass";
          src = inputs.bypass;
        };

        file-actions = {
          name = "file-actions";
          src = inputs.file-actions;
        };

        reflink = {
          name = "reflink";
          src = inputs.reflink;
        };

        smart-filter = {
          name = "smart-filter";
          src = yazi-plugins + "/smart-filter.yazi";
        };

        sudo = {
          name = "sudo";
          src = inputs.sudo;
        };

        # Git Integration
        git = {
          name = "git";
          src = yazi-plugins + "/git.yazi";
        };

        githead = {
          name = "githead";
          src = inputs.githead;
        };

        lazygit = {
          name = "lazygit";
          src = inputs.lazygit;
        };

        vcs-files = {
          name = "vcs-files";
          src = yazi-plugins + "/vcs-files.yazi";
        };

        # Image and Media Viewers
        allmytoes = {
          name = "allmytoes";
          src = inputs.allmytoes;
        };

        sxiv = {
          name = "sxiv";
          src = inputs.sxiv;
        };

        # MIME and File Type
        mime-ext = {
          name = "mime-ext";
          src = yazi-plugins + "/mime-ext.yazi";
        };

        # mime-ext-dreammaomao = {
        #   name = "mime-ext-dreammaomao";
        #   src = inputs.mime-ext-dreammaomao;
        # };

        # mime-preview = {
        #   name = "mime-preview";
        #   src = inputs.mime-preview;
        # };

        # Navigation and Bookmarks
        bunny = {
          name = "bunny";
          src = inputs.bunny;
        };

        # easyjump = {
        #   name = "easyjump";
        #   src = inputs.easyjump;
        # };

        # fg = {
        #   name = "fg";
        #   src = inputs.fg;
        # };

        projects = {
          name = "projects";
          src = inputs.projects;
        };

        # Previews
        # epub = {
        #   name = "epub";
        #   src = inputs.epub;
        # };

        eza-preview = {
          name = "eza-preview";
          src = inputs.eza-preview;
        };

        glow = {
          name = "glow";
          src = inputs.glow;
        };

        hexyl = {
          name = "hexyl";
          src = inputs.hexyl;
        };

        mdcat = {
          name = "mdcat";
          src = inputs.mdcat;
        };

        miller = {
          name = "miller";
          src = inputs.miller;
        };

        nbpreview = {
          name = "nbpreview";
          src = inputs.nbpreview;
        };

        office = {
          name = "office";
          src = inputs.office;
        };

        piper = {
          name = "piper";
          src = yazi-plugins + "/piper.yazi";
        };

        torrent-preview = {
          name = "torrent-preview";
          src = inputs.torrent-preview;
        };

        # Shell Integration
        command = {
          name = "command";
          src = inputs.command;
        };

        custom-shell = {
          name = "custom-shell";
          src = inputs.custom-shell;
        };

        nu = {
          name = "nu";
          src = inputs.nu;
        };

        # Smart Enter
        smart-enter = {
          name = "smart-enter";
          src = yazi-plugins + "/smart-enter.yazi";
        };

        # Themes
        crystal = {
          name = "crystal";
          src = inputs.crystal;
        };

        flexoki = {
          name = "flexoki";
          src = inputs.flexoki;
        };

        ls-colors = {
          name = "ls-colors";
          src = inputs.ls-colors;
        };

        rose-pine = {
          name = "rose-pine";
          src = inputs.rose-pine;
        };

        tokyonight-night = {
          name = "tokyonight-night";
          src = inputs.tokyonight-night + "/tokyonight-night.yazi";
        };

        # UI Enhancements
        auto-layout = {
          name = "auto-layout";
          src = inputs.auto-layout;
        };

        dual-pane = {
          name = "dual-pane";
          src = inputs.dual-pane;
        };

        file-extra-metadata = {
          name = "file-extra-metadata";
          src = inputs.file-extra-metadata;
        };

        full-border = {
          name = "full-border";
          src = yazi-plugins + "/full-border.yazi";
        };

        starship = {
          name = "starship";
          src = inputs.starship;
        };

        toggle-pane = {
          name = "toggle-pane";
          src = yazi-plugins + "/toggle-pane.yazi";
        };

        yatline = {
          name = "yatline";
          src = inputs.yatline;
        };

        yatline-symlink = {
          name = "yatline-symlink";
          src = inputs.yatline-symlink + "/yatline-symlink.yazi";
        };

        # Utilities
        chmod = {
          name = "chmod";
          src = yazi-plugins + "/chmod.yazi";
        };

        diff = {
          name = "diff";
          src = yazi-plugins + "/diff.yazi";
        };
      };
    in
    {
      inherit plugins;

      sources = inputs;

      pluginsList = builtins.attrValues plugins;
    };
}
