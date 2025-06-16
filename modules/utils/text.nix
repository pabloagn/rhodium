{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ripgrep # Silver searcher plus grep
    ripgrep-all # Ripgrep for extended file types
    fd # Better find
    jq # JSON processor
    yq # Command-line YAML, JSON, XML, and TOML processor
    sd # Better sed
  ];
}
