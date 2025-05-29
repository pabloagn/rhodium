{ pkgs, ... }:
{
  imports = [
    ./core
    ./files
    ./media
    ./misc
    ./monitoring
    ./productivity
    ./search
  ];
}
