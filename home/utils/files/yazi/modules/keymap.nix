{ ... }:
{
  mgr.prepend_keymap = [
    # ===== Fuzzy Search =====
    {
      on = [ "f" "f" ];
      run = "plugin fg -- fzf";
      desc = "Search files by name (fg)";
    }
    {
      on = [ "f" "g" ];
      run = "plugin fr rg";
      desc = "Search files by content using rg + fzf (fr)";
    }
    {
      on = [ "f" "G" ];
      run = "plugin fr rga";
      desc = "Search files by content using rga + fzf (fr)";
    }

    # ===== Go To Locations =====
    {
      on = [ "g" "r" ];
      run = "cd $RHODIUM";
      desc = "Go to rhodium";
    }
    {
      on = [ "g" "h" ];
      run = "cd $HOME";
      desc = "Go to user home";
    }
    {
      on = [ "g" "H" ];
      run = "cd $XDG_CACHE_HOME";
      desc = "Go to .cache";
    }
    {
      on = [ "g" "b" ];
      run = "cd $XDG_BIN_HOME";
      desc = "Go to ./local/bin";
    }
    {
      on = [ "g" "e" ];
      run = "cd $DOTCONFIG_DOOM";
      desc = "Go to ./config/doom";
    }
    {
      on = [ "g" "u" ];
      run = "cd $DEV_UTILS";
      desc = "Go to dev/utils";
    }
    {
      on = [ "g" "p" ];
      run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
      desc = "Go to Project Root";
    }
    {
      on = [ "g" "A" ];
      run = "cd $HOME/.local/share/applications/";
      desc = "Go to .local/share/applications";
    }
    {
      on = [ "g" "a" ];
      run = "cd $HOME_ACADEMIC";
      desc = "Go to academic";
    }
    {
      on = [ "g" "d" ];
      run = "cd $HOME_DOWNLOADS";
      desc = "Go to downloads";
    }
    {
      on = [ "g" "s" ];
      run = "cd $HOME_SOLENOIDLABS";
      desc = "Go to solenoid-labs";
    }

    # ===== Smart Navigation =====
    {
      on = [ "F" ];
      run = "plugin smart-filter";
      desc = "Smart Filter";
    }
    {
      on = [ "l" ];
      run = "plugin smart-enter";
      desc = "Smart Enter";
    }
    # Jump to character (vim-like f<char>) - using ; to avoid conflict with ff fuzzy
    {
      on = [ ";" ];
      run = "plugin jump-to-char";
      desc = "Jump to char (like vim f)";
    }

    # ===== Rename Operations =====
    {
      on = [ "r" "r" ];
      run = "rename --cursor=before_ext";
      desc = "Rename selected file(s)";
    }
    {
      on = [ "r" "a" ];
      run = "rename --empty=all --cursor=start";
      desc = "Rename clear selected file(s)";
    }
    {
      on = [ "r" "c" ];
      run = "rename --empty=stem --cursor=start";
      desc = "Rename change selected file(s)";
    }

    # ===== DuckDB (Structured Data Preview) =====
    {
      on = [ "H" ];
      run = "plugin duckdb -1";
      desc = "DuckDB: scroll columns left";
    }
    {
      on = [ "L" ];
      run = "plugin duckdb +1";
      desc = "DuckDB: scroll columns right";
    }
    # Toggle between summary and standard mode
    {
      on = [ "<C-d>" ];
      run = "plugin duckdb --toggle-mode";
      desc = "DuckDB: toggle summary/standard mode";
    }

    # ===== Git Integration =====
    {
      on = [ "g" "i" ];
      run = "plugin lazygit";
      desc = "Open LazyGit";
    }
    {
      on = [ "g" "D" ];
      run = "plugin diff";
      desc = "Diff selected files";
    }

    # ===== Drag and Drop (dragon-drop) =====
    {
      on = [ "<C-g>" ];
      run = ''shell -- dragon -x -i -T "$@"'';
      desc = "Drag files to other apps";
    }
    {
      on = [ "<A-g>" ];
      run = ''shell -- dragon -x -i -T -a'';
      desc = "Drag all selected files";
    }

    # ===== Clipboard (Cross-Instance via Wayland) =====
    {
      on = [ "Y" ];
      run = "plugin wl-clipboard";
      desc = "Copy files to system clipboard (Wayland)";
    }

    # ===== Archive Operations =====
    {
      on = [ "c" "a" ];
      run = "plugin compress";
      desc = "Compress selected files";
    }
    {
      on = [ "c" "x" ];
      run = "plugin ouch --extract";
      desc = "Extract archive here";
    }

    # ===== Pane Management =====
    {
      on = [ "T" ];
      run = "plugin toggle-pane --max-preview";
      desc = "Maximize preview pane";
    }
    {
      on = [ "<C-t>" ];
      run = "plugin toggle-pane --min-preview";
      desc = "Minimize preview pane";
    }

    # ===== File Operations =====
    {
      on = [ "c" "m" ];
      run = "plugin chmod";
      desc = "Change file permissions";
    }
    {
      on = [ "c" "s" ];
      run = "plugin sudo";
      desc = "Execute with sudo";
    }
    {
      on = [ "m" "m" ];
      run = "plugin mount";
      desc = "Mount/unmount disk";
    }

    # ===== Media Info =====
    {
      on = [ "M" ];
      run = "plugin mediainfo";
      desc = "Show media info";
    }

    # ===== Paste Operations =====
    {
      on = [ "p" ];
      run = "plugin smart-paste";
      desc = "Paste files";
    }

    # ===== Projects =====
    {
      on = [ "P" "s" ];
      run = "plugin projects --save";
      desc = "Save current as project";
    }
    {
      on = [ "P" "l" ];
      run = "plugin projects --load";
      desc = "Load project";
    }
    {
      on = [ "P" "d" ];
      run = "plugin projects --delete";
      desc = "Delete project";
    }
    {
      on = [ "P" "D" ];
      run = "plugin projects --delete-all";
      desc = "Delete all projects";
    }
    {
      on = [ "P" "m" ];
      run = "plugin projects --merge";
      desc = "Merge with other projects";
    }

    # ===== Restore Deleted Files =====
    {
      on = [ "u" "r" ];
      run = "plugin restore";
      desc = "Restore deleted files";
    }

    # ===== Relative Motions (vim-like) =====
    {
      on = [ "1" ];
      run = "plugin relative-motions -- 1";
      desc = "Move 1 line";
    }
    {
      on = [ "2" ];
      run = "plugin relative-motions -- 2";
      desc = "Move 2 lines";
    }
    {
      on = [ "3" ];
      run = "plugin relative-motions -- 3";
      desc = "Move 3 lines";
    }
    {
      on = [ "4" ];
      run = "plugin relative-motions -- 4";
      desc = "Move 4 lines";
    }
    {
      on = [ "5" ];
      run = "plugin relative-motions -- 5";
      desc = "Move 5 lines";
    }
    {
      on = [ "6" ];
      run = "plugin relative-motions -- 6";
      desc = "Move 6 lines";
    }
    {
      on = [ "7" ];
      run = "plugin relative-motions -- 7";
      desc = "Move 7 lines";
    }
    {
      on = [ "8" ];
      run = "plugin relative-motions -- 8";
      desc = "Move 8 lines";
    }
    {
      on = [ "9" ];
      run = "plugin relative-motions -- 9";
      desc = "Move 9 lines";
    }
  ];
}
