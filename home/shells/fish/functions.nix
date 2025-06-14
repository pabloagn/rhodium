{ ... }:

{
  xdg.configFile."fish/functions" = {
    source = ./fish/functions;
    recursive = true;
  };
}
