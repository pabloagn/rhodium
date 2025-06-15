{...}: {
  programs.fish = {
    interactiveShellInit = ''
      # Atuin
      set -gx ATUIN_NOBIND true
      atuin init fish --disable-up-arrow | source

      # Keybinds
      # Function Keybinds

      # Normal mode
      bind \ct 'jtf; commandline -f repaint'           # Ctrl+T for Jump To File
      bind \co 'jtd; commandline -f repaint'           # Ctrl+O for Jump To Dir
      bind \cp 'jtp; commandline -f repaint'           # Ctrl+P for Jump To Project
      bind \cy 'yy; commandline -f repaint'            # Ctrl+Y for Yazi file manager

      # Insert Mode
      bind -M insert \ct 'jtf; commandline -f repaint'   # Ctrl+T for Jump To File (Insert Mode)
      bind -M insert \co 'jtd; commandline -f repaint'   # Ctrl+O for Jump To Dir  (Insert Mode)
      bind -M insert \cp 'jtp; commandline -f repaint'   # Ctrl+P for Jump To Project (Insert Mode)
      bind -M insert \cy 'yy; commandline -f repaint'    # Ctrl+Y for Yazi file manager (Insert Mode)
      bind -M insert \ch 'hh; commandline -f repaint'    # Ctrl+H for Help (Insert Mode)

      # Atuin
      bind \cr '_atuin_search'  # Ctrl+R for atuin
      bind -M insert \cr '_atuin_search'

      # Vi mode clipboard bindings
      bind -M visual y 'commandline -s | wl-copy; commandline -f end-selection repaint-mode'
      bind -M default p 'commandline -i (wl-paste)'

      # # Theme
      # set -g fish_color_autosuggestion 555 brblack
      set -g fish_color_command green
      set -g fish_color_error red
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_comment brblack
      set -g fish_color_match --bold --background=brblue
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_search_match bryellow --background=brblack
      set -g fish_color_operator bryellow
      set -g fish_color_escape bryellow --bold
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red

      # Prompt
      function fish_prompt
          set -l last_status $status
          set -l cwd (prompt_pwd)

          if test $last_status -eq 0
              set_color green
              echo -n "➜ "
          else
              set_color red
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
      set -g man_blink -o red
      set -g man_bold -o green
      set -g man_standout -b black 93a1a1
      set -g man_underline -u 93a1a1

    '';
  };
}
