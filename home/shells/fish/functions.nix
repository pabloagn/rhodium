{ ... }:
{
  xdg.configFile."fish/functions" = {
    source = ./functions;
    recursive = true;
  };
}
