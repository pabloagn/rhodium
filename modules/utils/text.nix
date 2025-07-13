{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd # Better find
    jq # JSON processor
    ripgrep # Silver searcher plus grep
    ripgrep-all # Ripgrep for extended file types
    sd # Better sed
    yq # Command-line YAML, JSON, XML, and TOML processor
  ];
}
