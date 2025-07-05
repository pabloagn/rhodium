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
            set -g fish_pager_color_secondary_background      4B5F6F --background normal     # Pager #4B5F6F
            set -g fish_pager_color_background                4B5F6F --background normal     # Pager #4B5F6F
            set -g fish_color_autosuggestion                  4B5F6F                         # Autosuggestions #4B5F6F
            set -g fish_color_command                         7FB4CA                         # Commands #7FB4CA
            set -g fish_color_comment                         4B5F6F                         # Code comments #4B5F6F
            set -g fish_color_cwd                             7AA89F                         # Current working directory #7AA89F
            set -g fish_color_end                             b6927b                         # Process separators #b6927b
            set -g fish_color_error                           E46876                         # Highlight potential errors #E46876
            set -g fish_color_escape                          8ea4a2                         # Character escapes #8ea4a2
            set -g fish_color_match                           938AA9                         # Matching parenthesis #938AA9
            set -g fish_color_normal                          A2A5A2                         # Default color #A2A5A2
            set -g fish_color_operator                        E6C384                         # Parameter expansion operators #E6C384
            set -g fish_color_param                           A2A5A2                         # Regular command parameters #A2A5A2
            set -g fish_color_quote                           87a987                         # Quoted blocks of text #87a987
            set -g fish_color_redirection                     a292a3                         # IO redirections #a292a3
            set -g fish_color_search_match                    4B5F6F --background E6C384     # Highlight search matches #E6C384 #4B5F6F
            set -g fish_color_selection                       4B5F6F --background E6C384     # Text selection #E6C384 #4B5F6F
            set -g fish_color_cancel                          0d0c0c                         # The '^C' indicator #0d0c0c
            set -g fish_color_host                            938AA9                         # Current host system #938AA9
            set -g fish_color_host_remote                     938AA9                         # Remote host system #938AA92
            set -g fish_color_user                            b98d7b                         # Current username #b98d7b

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
            set -g man_blink -o 2D4F67 #2D4F67
            set -g man_bold -o 87a987 #87a987
            set -g man_standout -b black 93a1a1 #93a1a1
            set -g man_underline -u 93a1a1 #93a1a1

    '';
  };
}
