{ pkgs }:

let
  script = pkgs.writeShellScript "yazi-markdown-preview" ''
    #!${pkgs.runtimeShell}
    if ! command -v pandoc >/dev/null 2>&1; then
      echo "Preview Error: 'pandoc' command not found in wrapper environment." >&2
      exit 1
    fi
    if ! command -v w3m >/dev/null 2>&1; then
      echo "Preview Error: 'w3m' command not found in wrapper environment." >&2
      exit 1
    fi
    FILE_PATH="$1"
    WIDTH="''${YACOL:-80}"
    (${pkgs.pandoc}/bin/pandoc -f markdown -t html --standalone "$FILE_PATH" 2>&1 | ${pkgs.w3m}/bin/w3m -T text/html -dump -cols "$WIDTH")
    exit $?
  '';
in
{
  source = script;
  executable = true;
}
