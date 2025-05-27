{ config, ... }:
{
  programs.yazi = {
    keymap = {
      manager = {
        # Copy file to system clipboard
        prepend_keymap = [
          {
            on = "y";
            run = [
              "shell -- for path in \"$@\"; do echo \"file://$path\"; done | wl-copy -t text/uri-list"
              "yank"
            ];
          }
        ];
      };
    };
  };
}
