{...}: {
  mgr.prepend_keymap = [
    # GoToS
    {
      on = ["g" "r"];
      run = "cd $RHODIUM";
      desc = "Go to rhodium";
    }
    {
      on = ["g" "h"];
      run = "cd $XDG_CACHE_HOME";
      desc = "Go to .cache";
    }
    {
      on = ["g" "b"];
      run = "cd $XDG_BIN_HOME";
      desc = "Go to ./local/bin";
    }
    {
      on = ["g" "u"];
      run = "cd $DEV_UTILS";
      desc = "Go to dev/utils";
    }
    {
      on = ["g" "p"];
      run = "shell -- ya emit cd '$(git rev-parse --show-toplevel)'";
      desc = "Go to Project Root";
    }
    {
      on = ["g" "A"];
      run = "cd $XDG_SHARE_APPS";
      desc = "Go to .local/share/apps";
    }
    {
      on = ["g" "a"];
      run = "cd $HOME_ACADEMIC";
      desc = "Go to academic";
    }
    {
      on = ["g" "d"];
      run = "cd $HOME_DOWNLOADS";
      desc = "Go to downloads";
    }
    {
      on = ["g" "s"];
      run = "cd $HOME_SOLENOIDLABS";
      desc = "Go to solenoid-labs";
    }
    # Smarts
    {
      on = ["F"];
      run = "plugin smart-filter";
      desc = "Smart Filter";
    }
    {
      on = ["l"];
      run = "plugin smart-enter";
      desc = "Smart Enter";
    }
  ];
}
