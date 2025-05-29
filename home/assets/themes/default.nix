{ lib, ... }:
{
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    description = "Theme configuration passed from flake";
    default = {};
  };
}
