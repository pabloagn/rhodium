{ pkgs, ... }:

{
  imports = [
    # ./alacritty/alacritty.nix
    ./foot/foot.nix
    ./ghostty/ghostty.nix
    ./kitty/kitty.nix
    # ./st/st.nix
    # ./wezterm/wezterm.nix
  ];
}
