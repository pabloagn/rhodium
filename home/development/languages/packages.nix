{pkgs, ...}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
        ipykernel
        jupyter
        numpy
        matplotlib
        pandas
        wcwidth
      ]))
  ];
}
