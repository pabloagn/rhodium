{ pkgs, ... }:

{
  imports = [
    ./databases
    ./infra
    ./languages
    ./opsec
    ./versioning
  ];

  home.packages = with pkgs; [
    postman
    ollama
  ];
}
