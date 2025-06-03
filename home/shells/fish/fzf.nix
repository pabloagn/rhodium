{ ... }:

''
  # FZF integration
  set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
  set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border=sharp \
    --preview-window=right:60%:wrap \
    --bind='ctrl-/:toggle-preview' \
    --bind='ctrl-u:preview-half-page-up' \
    --bind='ctrl-d:preview-half-page-down' \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

  # File preview for FZF
  set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --level=2 --color=always {}'"
''
