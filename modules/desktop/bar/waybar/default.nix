{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar

    # Attribute override (bug fixes)
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
  ];
}
