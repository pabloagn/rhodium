{ ... }:

{
  programs.fish = {
    shellInit = ''
      fish_vi_key_bindings # Enable vi mode
      set -g fish_greeting # Disable greeting

      set -g fish_cursor_default block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore

      set -g fish_vi_force_cursor 1

      # History settings
      set -g history_max 1000000
    '';
  };
}
