{ pkgs, ... }:
{
  imports = [
    ./containers
    ./remote
    ./vm
  ];
}
