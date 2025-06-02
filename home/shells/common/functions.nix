{ ... }:
{
  # Rhodium system management function
  rh = ''
    # Rhodium system rebuilding function
    function rh() {
      # Store the current directory
      local current_dir=$(pwd)

      # Go to the Rhodium directory
      cd "$RHODIUM"

      # Process arguments
      case "$1" in
        -h|--home)
          echo "Rebuilding home configuration..."
          home-manager switch --flake .#pabloagn
          ;;
        -s|--system)
          echo "Rebuilding system configuration..."
          sudo nixos-rebuild switch --flake .
          ;;
        -a|--all)
          echo "Rebuilding all configurations (system and home)..."
          sudo nixos-rebuild switch --flake .
          home-manager switch --flake .#pabloagn
          ;;
        -c|--check)
          echo "Checking configurations..."
          nixos-rebuild build --flake .
          home-manager build --flake .#pabloagn
          ;;
        *)
          echo "Rhodium system management"
          echo "Usage: rh [option]"
          echo "  -h, --home    Rebuild home configuration"
          echo "  -s, --system  Rebuild system configuration"
          echo "  -a, --all     Rebuild both system and home"
          echo "  -c, --check   Check configurations without applying"
          ;;
      esac

      # Return to the original directory
      cd "$current_dir"
    }
  '';

  # Let yazi cd into directories (shell wrapper)
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
}
