{pkgs, ...}: {
  home.packages = with pkgs; [
    socat # Using for CommonLisp
    rlwrap # Using for CommonLisp
  ];
}

