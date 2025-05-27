{ pkgs, ... }:

{
  imports = [
    ./databases
    ./languages
    ./opsec
    ./versioning
  ];

  home.packages = with pkgs; [
    postman
    ollama
  ];
}
