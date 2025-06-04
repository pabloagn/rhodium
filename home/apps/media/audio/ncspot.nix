{ ... }:
# TODO: Customize ncspot
{
  imports = [
    ./ncspot
  ];

  programs.ncspot = {
    enable = true;
  };
}
