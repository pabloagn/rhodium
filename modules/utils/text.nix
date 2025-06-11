{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep-all # Better ripgrep
    fd # Better find
    jq # JSON processor
    yq # Command-line YAML, JSON, XML, and TOML processor
    sd # Better sed
  ];
}
