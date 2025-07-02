{...}: {
  programs.starship.settings = let
    # hostInfo = "\${custom.rhodium}$username$hostname($shlvl)($cmd_duration)";
    hostInfo = "$username$hostname($shlvl)($cmd_duration)";
    nixInfo = "($nix_shell)";
    localInfo = "$directory($git_branch$git_commit$git_state$git_status$git_metrics)$all";
    prompt = "$jobs$character";
  in {
    format = ''
      ${hostInfo}
      ${localInfo} $fill ${nixInfo}
      ${prompt}
    '';
    fill.symbol = " ";
  };
}
