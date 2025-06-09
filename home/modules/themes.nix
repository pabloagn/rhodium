{ pkgs, ... }:

let
  tokyonightSrc = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "b262293ef481b0d1f7a14c708ea7ca649672e200";
    sha256 = "1cd8wxgicfm5f6g7lzqfhr1ip7cca5h11j190kx0w52h0kbf9k54";
  };

  extras = "${tokyonightSrc}/extras";
  variants = [ "day" "moon" "night" "storm" ];

  mkVariantPaths = app: ext: builtins.listToAttrs (map
    (variant: {
      name = variant;
      value = "${extras}/${app}/tokyonight_${variant}${ext}";
    })
    variants);

in
{
  themes.tokyonight = {
    src = tokyonightSrc;

    # Terminal emulators
    alacritty = mkVariantPaths "alacritty" ".toml";
    foot = mkVariantPaths "foot" ".ini";
    ghostty = mkVariantPaths "ghostty" "";
    kitty = mkVariantPaths "kitty" ".conf";
    st = mkVariantPaths "st" ".h";
    wezterm = mkVariantPaths "wezterm" ".toml";

    # Editors
    helix = mkVariantPaths "helix" ".toml";
    sublime = mkVariantPaths "sublime" ".tmTheme";
    vim = {
      day = "${extras}/vim/colors/tokyonight-day.vim";
      moon = "${extras}/vim/colors/tokyonight-moon.vim";
      night = "${extras}/vim/colors/tokyonight-night.vim";
      storm = "${extras}/vim/colors/tokyonight-storm.vim";
    };

    # File managers
    yazi = mkVariantPaths "yazi" ".toml";

    # Launchers
    fuzzel = mkVariantPaths "fuzzel" ".ini";

    # Document viewers
    zathura = mkVariantPaths "zathura" ".zathurarc";

    # Development tools
    delta = mkVariantPaths "delta" ".gitconfig";
    gitui = mkVariantPaths "gitui" ".ron";
    lazygit = mkVariantPaths "lazygit" ".yml";

    # Shells and prompts
    fish = mkVariantPaths "fish" ".fish";
    fish_themes = mkVariantPaths "fish_themes" ".theme";
    fzf = mkVariantPaths "fzf" ".sh";

    # Terminal multiplexers
    tmux = mkVariantPaths "tmux" ".tmux";
    zellij = mkVariantPaths "zellij" ".kdl";

    # Notifications
    dunst = mkVariantPaths "dunst" ".dunstrc";

    # Media
    spotify_player = mkVariantPaths "spotify_player" ".toml";

    # Mail
    aerc = mkVariantPaths "aerc" ".ini";

    # Chat
    discord = mkVariantPaths "discord" ".css";
    slack = mkVariantPaths "slack" ".txt";

    # Language support
    lua = mkVariantPaths "lua" ".lua";
    prism = mkVariantPaths "prism" ".js";

    # eza only has one file
    eza = "${extras}/eza/tokyonight.yml";
  };
}
