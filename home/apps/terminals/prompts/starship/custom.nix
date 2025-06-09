{ config, rhodiumLib, ... }:

let
  icons = config.theme.icons.iconsNerdFont;
  formatIcon = rhodiumLib.formatters.iconFormatter.formatIcon;
in
{
  programs.starship.settings = {
    # Custom modules
    custom.rhodium_test = {
      command = "echo $RHODIUM_TEST_ENV";
      when = "test -n '$RHODIUM_TEST_ENV'";
      format = "[$output](bold yellow) ";
      description = "Show current Rhodium test environment";
    };
  };
}
