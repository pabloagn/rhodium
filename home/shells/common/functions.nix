{ ... }:

{
  zshFunctions = {
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
  };

  fishFunctions = {
    yy = ''
      function yy
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end
    '';

    # Reduce direnv verbosity
    __direnv_export_eval = ''
      function __direnv_export_eval --on-event fish_prompt
        begin
          begin
            direnv export fish
          end 1>| source
        end 2>| egrep -v -e "^direnv: (export|loading|using|nix-direnv:)" -e "Welcome to"
      end
    '';
  };
}
