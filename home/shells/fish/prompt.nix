{ ... }:

''
  # Custom prompt - clean and minimal
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
''
