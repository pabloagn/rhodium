{...}: {
  programs.fish = {
    interactiveShellInit = ''
      # --- Atuin ---
      set -gx ATUIN_NOBIND true
      atuin init fish --disable-up-arrow | source

      # --- Keybinds ---

      # Normal Mode
      bind \ct 'jtf; commandline -f repaint'              # Ctrl+T for Jump To File
      bind \co 'jtd; commandline -f repaint'              # Ctrl+O for Jump To Dir
      bind \cp 'jtp; commandline -f repaint'              # Ctrl+P for Jump To Project
      bind \cy 'yy; commandline -f repaint'               # Ctrl+Y for Yazi file manager
      bind \ch 'h; commandline -f repaint'                # Ctrl+H for Simple Hist on Pager (Insert Mode)

      # Insert Mode
      bind -M insert \ct 'jtf; commandline -f repaint'    # Ctrl+T for Jump To File (Insert Mode)
      bind -M insert \co 'jtd; commandline -f repaint'    # Ctrl+O for Jump To Dir  (Insert Mode)
      bind -M insert \cp 'jtp; commandline -f repaint'    # Ctrl+P for Jump To Project (Insert Mode)
      bind -M insert \cy 'yy; commandline -f repaint'     # Ctrl+Y for Yazi file manager (Insert Mode)
      bind -M insert \ch 'h; commandline -f repaint'      # Ctrl+H for Simple Hist on Pager (Insert Mode)

      # Atuin
      bind \cr '_atuin_search'  # Ctrl+R for atuin
      bind -M insert \cr '_atuin_search'

      # Vi mode clipboard bindings
      bind -M visual y 'commandline -s | wl-copy; commandline -f end-selection repaint-mode'
      bind -M default p 'commandline -i (wl-paste)'

      # --- Theme ---
      set -g fish_color_autosuggestion A4A7A4 # kanso:color8      autosuggestions (muted gray)
      set -g fish_color_command        7FB4CA # kanso:color12     commands (bright blue)
      set -g fish_color_comment        4B5F6F # kanso:color18     code comments (dark blue-gray)
      set -g fish_color_cwd            7AA89F # kanso:color14     current working directory (bright cyan)
      set -g fish_color_end            b6927b # kanso:color16     process separators (brown)
      set -g fish_color_error          E46876 # kanso:color9      highlight potential errors (bright red)
      set -g fish_color_escape         8ea4a2 # kanso:color6      character escapes (cyan)
      set -g fish_color_match          938AA9 # kanso:color13     matching parenthesis (bright purple)
      set -g fish_color_normal         C8C093 # kanso:color7      default color (light tan)
      set -g fish_color_operator       E6C384 # kanso:color11     parameter expansion operators (bright yellow)
      set -g fish_color_param          C8C093 # kanso:color7      regular command parameters (light tan)
      set -g fish_color_quote          87a987 # kanso:color10     quoted blocks of text (bright green)
      set -g fish_color_redirection    a292a3 # kanso:color5      IO redirections (purple)
      set -g fish_color_search_match   --background E6C384 # kanso:color11  highlight search matches (bright yellow bg)
      set -g fish_color_selection      E6C384 # kanso:color11     text selection (bright yellow)
# color for fish default prompts item
      set -g fish_color_cancel         0d0c0c # kanso:color0      the '^C' indicator (dark background)
      set -g fish_color_host           938AA9 # kanso:color13     current host system (bright purple)
      set -g fish_color_host_remote    938AA9 # kanso:color13     remote host system (bright purple)
      set -g fish_color_user           b98d7b # kanso:color17     current username (orange-brown)

      # Prompt
      function fish_prompt
          set -l last_status $status
          set -l cwd (prompt_pwd)

          if test $last_status -eq 0
              set_color 4B5F6F
              echo -n "➜ "
          else
              set_color E46876
              echo -n "➜ "
          end

          set_color blue
          echo -n $cwd
          set_color normal
          echo -n " "
      end

      # Right prompt for git
      function fish_right_prompt
          set_color brblack
          echo -n (date +%H:%M)
          set_color normal
      end

      # Plugin setup
      # colored-man
      # TODO: Style this
      set -g man_blink -o 2D4F67
      set -g man_bold -o green
      set -g man_standout -b black 93a1a1
      set -g man_underline -u 93a1a1

    '';
  };
}
