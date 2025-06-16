{config, ...}: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    # enableFishIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # Cache .env environment
    silent = true; # Silence direnv messages

    config = {
      # Whitelist configuration
      whitelist = {
        # Allow entire directory hierarchies
        prefix = [
          "${config.home.homeDirectory}/dev"
          "${config.home.homeDirectory}/solenoid-labs"
          "${config.home.homeDirectory}/professional"
          "${config.home.homeDirectory}/academic"
        ];
      };

      warn_timeout = "10s"; # Warning timeout
      disable_stdin = true; # Disable stdin during .envrc evaluation
    };
  };
}
