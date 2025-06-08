{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep # Better grep # Better grep
    fd # Better find
    jq # JSON processor
    yq # Command-line YAML, JSON, XML, and TOML processor
  ];
}
