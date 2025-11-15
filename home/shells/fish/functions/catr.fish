function catr --description "Cat all files recursively and copy to clipboard"
    find . \
        -type d \( -name ".env" -o -name ".venv" -o -name __pycache__ -o -name ".git" -o -name ".direnv" \) -prune -o \
        -type f ! -name "flake.lock" ! -name "uv.lock" -print0 | xargs -0 -I {} sh -c 'echo {}; cat "{}"; echo "-----"' | wl-copy
end

complete -c catr -f
