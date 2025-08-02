{ ... }:
{
  mgr.prepend_keymap = [
    # Fuzzy
    {
      on = [
        "f"
        "f"
      ];
      run = "plugin fg -- fzf";
      desc = "Search files by name (fg)";
    }
    {
      on = [
        "f"
        "g"
      ];
      run = "plugin fr rg";
      desc = "Search files by content using rg + fzf (fr)";
    }
    {
      on = [
        "f"
        "G"
      ];
      run = "plugin fr rga";
      desc = "Search files by content using rga + fzf (fr)";
    }

    # GoToS
    {
      on = [
        "g"
        "r"
      ];
      run = "cd $RHODIUM";
      desc = "Go to rhodium";
    }
    {
      on = [
        "g"
        "h"
      ];
      run = "cd $HOME";
      desc = "Go to user home";
    }
    {
      on = [
        "g"
        "H"
      ];
      run = "cd $XDG_CACHE_HOME";
      desc = "Go to .cache";
    }
    {
      on = [
        "g"
        "b"
      ];
      run = "cd $XDG_BIN_HOME";
      desc = "Go to ./local/bin";
    }
    {
      on = [
        "g"
        "e"
      ];
      run = "cd $DOTCONFIG_DOOM";
      desc = "Go to ./config/doom";
    }
    {
      on = [
        "g"
        "u"
      ];
      run = "cd $DEV_UTILS";
      desc = "Go to dev/utils";
    }
    {
      on = [
        "g"
        "p"
      ];
      run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
      desc = "Go to Project Root";
    }
    {
      on = [
        "g"
        "A"
      ];
      run = "cd $HOME/.local/share/applications/";
      desc = "Go to .local/share/applications";
    }
    {
      on = [
        "g"
        "a"
      ];
      run = "cd $HOME_ACADEMIC";
      desc = "Go to academic";
    }
    {
      on = [
        "g"
        "d"
      ];
      run = "cd $HOME_DOWNLOADS";
      desc = "Go to downloads";
    }
    {
      on = [
        "g"
        "s"
      ];
      run = "cd $HOME_SOLENOIDLABS";
      desc = "Go to solenoid-labs";
    }
    # Smarts
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
    # Renames
    {
      on = [
        "r"
        "r"
      ];
      run = "rename --cursor=before_ext";
      desc = "Rename selected file(s)";
    }
    {
      on = [
        "r"
        "a"
      ];
      run = "rename --empty=all --cursor=start";
      desc = "Rename clear selected file(s)";
    }
    {
      on = [
        "r"
        "c"
      ];
      run = "rename --empty=stem --cursor=start";
      desc = "Rename change selected file(s)";
    }
  ];
}
