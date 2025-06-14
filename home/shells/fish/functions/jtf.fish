function jtf --description "Jump To File: Fuzzy file finder with preview"
    set -l file (fd -t f --strip-cwd-prefix | fzf --preview 'bat --color=always --style=plain {}')
    if test -n "$file"
        $EDITOR "$file"
    end
end

complete -c jtf -f
