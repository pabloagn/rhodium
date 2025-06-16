{...}: {
  imports = [
    ./btop
  ];

  programs.btop = {
    enable = true;
  };
}
