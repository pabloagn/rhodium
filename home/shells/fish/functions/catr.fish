function catr --description "Cat all text-like project files recursively and copy to clipboard"
    find . \
        -type d \( \
        -name ".env" -o \
        -name ".venv" -o \
        -name env -o \
        -name venv -o \
        -name __pycache__ -o \
        -name ".git" -o \
        -name ".direnv" -o \
        -name ".mypy_cache" -o \
        -name ".pytest_cache" -o \
        -name node_modules -o \
        -name build -o \
        -name dist -o \
        -name ".ruff_cache" \
        \) -prune -o \
        -type f \( \
        -name "*.csv" -o \
        -name "*.tsv" -o \
        -name "*.parquet" -o \
        -name "*.pq" -o \
        -name "*.feather" -o \
        -name "*.arrow" -o \
        -name "*.avro" -o \
        -name "*.orc" -o \
        -name "*.h5" -o \
        -name "*.hdf5" -o \
        -name "*.npz" -o \
        -name "*.npy" -o \
        -name "*.jpg" -o \
        -name "*.jpeg" -o \
        -name "*.png" -o \
        -name "*.gif" -o \
        -name "*.bmp" -o \
        -name "*.ico" -o \
        -name "*.pdf" -o \
        -name "*.zip" -o \
        -name "*.tar" -o \
        -name "*.gz" -o \
        -name "*.xz" -o \
        -name "*.7z" -o \
        -name "*.jar" -o \
        -name "*.db" -o \
        -name "*.sqlite" -o \
        -name "*.sqlite3" -o \
        -name "*.log" -o \
        -name "*.ipynb" -o \
        -name "*.lock" -o \
        -name "flake.lock" -o \
        -name "uv.lock" \
        \) -prune -o \
        -type f -print0 \
        | xargs -0 -I {} sh -c 'echo {}; cat "{}"; echo "-----"' \
        | wl-copy
end

complete -c catr -f
