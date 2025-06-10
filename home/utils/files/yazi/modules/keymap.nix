{ ... }:

{
  mgr.prepend_keymap = [

    # GoTo
    { on = [ "g" "r" ]; run = "cd $RHODIUM"; desc = "Go to rhodium"; }

    { on = [ "g" "u" ]; run = "cd $DEV_UTILS"; desc = "Go to dev/utils"; }
    { on = [ "g" "p" ]; run = "cd $DEV_PHANTOM"; desc = "Go to dev/phantom"; }

    { on = [ "g" "a" ]; run = "cd $HOME_ACADEMIC"; desc = "Go to academic"; }
    { on = [ "g" "d" ]; run = "cd $HOME_DOWNLOADS"; desc = "Go to downloads"; }
    { on = [ "g" "s" ]; run = "cd $HOME_SOLENOIDLABS"; desc = "Go to solenoid-labs"; }


    # TODO: Add more entries here

    # Plugins
    # ----------------------------------------
    # Plugin: chmod
    # { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod on selected files"; }

    # Plugin: copy-file-contents
    # { on = [ "<A-y>" ]; run = [ "plugin copy-file-contents" ]; desc = "Copy contents of file"; }

    # Plugin: file-actions
    # Note: This was [[manager.prepend_keymap]] in original - changed to mgr for consistency
    # { on = [ "f" ]; run = "plugin file-actions -- --around "; desc = "Perform actions on selected files"; }

    # Plugin: wl-clipboard
    # { on = [ "<C-y>" ]; run = [ "plugin wl-clipboard" ]; desc = "Copy contents to wl-clipboard"; }

    # Plugin: mount
    # { on = [ "M" ]; run = "plugin mount"; }

    # Plugin: smart-filter
    # { on = [ "F" ]; run = "plugin smart-filter"; desc = "Smart filter"; }
  ];
}
