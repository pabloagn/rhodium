{ ... }:
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    # Default command for file finding
    defaultCommand = "fd --type f --strip-cwd-prefix";

    # Default options applied to all fzf invocations
    defaultOptions = [
      "--preview-window=right:50%:wrap"
      "--color=bg+:-1,bg:-1,border:240,spinner:108,hl:108,fg:252,header:108,info:108,pointer:161,marker:161,fg+:252,prompt:161,hl+:161"
      "--border=sharp"
      "--margin=1"
      "--padding=1"
    ];

    # Custom color scheme
    colors = {
      "bg+" = "-1";
      "bg" = "-1";
      "border" = "240";
      "spinner" = "108";
      "hl" = "108";
      "fg" = "252";
      "header" = "108";
      "info" = "108";
      "pointer" = "161";
      "marker" = "161";
      "fg+" = "252";
      "prompt" = "161";
      "hl+" = "161";
    };
  };
}
