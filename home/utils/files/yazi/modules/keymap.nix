{ ... }:

{
  mgr.prepend_keymap = [
    # Custom Keymaps
    # ----------------------------------------
    # GoTo
    # { on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home"; }
    { on = [ "g" "r" ]; run = "cd ~/rhodium"; desc = "Go to rhodium"; }
    { on = [ "g" "p" ]; run = "cd ~/projects"; desc = "Go to projects"; }
    # { on = [ "g" "c" ]; run = "cd ~/.config"; desc = "Go to config"; }
    { on = [ "g" "d" ]; run = "cd ~/downloads"; desc = "Go to downloads"; }
    { on = [ "g" "s" ]; run = "cd ~/solenoid-labs/"; desc = "Go to Solenoid Labs"; }

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
