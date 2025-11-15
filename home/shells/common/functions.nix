{ ... }:
{
  yy = ''
    function yy() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';

  catr = ''
    function catr() {
      find . \
        -type d \( -name ".env" -o -name ".venv" -o -name "pycache" -o -name "__pycache__" \) -prune -o \
        -type f ! -name "flake.lock" ! -name "uv.lock" -print0 | \
      while IFS= read -r -d ''' f; do
        echo "$f"
        cat "$f"
        echo "-----"
      done | wl-copy
    }
  '';
}
