{ config, ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
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
      
      # Allow specific directories or files only
      exact = [
      ];
    };

    # Warning timeout
    warn_timeout = "10s";
    
    # Disable stdin during .envrc evaluation
    disable_stdin = true;
  };
  };
}
