{ ... }:
{
  imports = [
    ./ncspot
  ];

  programs.ncspot = {
    enable = true;
  };
}
