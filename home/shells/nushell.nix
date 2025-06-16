{...}: {
  imports = [
    ./nushell
  ];

  programs.nushell = {
    enable = true;
  };
}
