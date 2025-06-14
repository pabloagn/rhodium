function jtd --description "Jump To Dir: Fuzzy dir finder with preview"
    set -l dir (fd -t d --strip-cwd-prefix | fzf --preview 'eza --tree --level=4 --color=always {}')
    if test -n "$dir"
        cd "$dir"
    end
end

complete -c jtd -f
