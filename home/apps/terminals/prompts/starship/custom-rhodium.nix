{ ... }:
let
  c = {
    # Normal
    color0 = "#0d0c0c";
    color1 = "#c4746e";
    color2 = "#8a9a7b";
    color3 = "#c4b28a";
    color4 = "#8ba4b0";
    color5 = "#a292a3";
    color6 = "#8ea4a2";
    color7 = "#C8C093";
    # Bright
    color8 = "#A4A7A4";
    color9 = "#E46876";
    color10 = "#87a987";
    color11 = "#E6C384";
    color12 = "#7FB4CA";
    color13 = "#938AA9";
    color14 = "#7AA89F";
    color15 = "#C5C9C7";
    # Extended
    color16 = "#b6927b";
    color17 = "#b98d7b";
    color18 = "#4B5F6F";
    color19 = "#4a7fff";
    color20 = "#59bfaa";
  };

  i = {
    icon01 = "◆";
  };
in
let
  viaColor = c.color18;
  colors = c;
in
{
  programs.starship.settings = {
    custom.rhodium = {
      disabled = true;
      command = "echo 'Rh'";
      when = "true";
      format = "[$output]($style) ${i.icon01} ";
      style = "#A4A7A4";
    };
  };
}
