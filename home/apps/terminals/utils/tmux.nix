{...}: {
  imports = [
    ./tmux
  ];

  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
  };
}
