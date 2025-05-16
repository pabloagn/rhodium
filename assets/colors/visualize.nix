# assets/colors/visualize.nix

let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  colors = import ./colors.nix;
in
pkgs.writeTextFile {
  name = "color-palette";
  text = ''
    <!DOCTYPE html>
    <html>
    <head>
      <title>Color Palette</title>
      <style>
        body { font-family: sans-serif; max-width: 1200px; margin: 0 auto; padding: 20px; }
        .color-grid { display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 30px; }
        .color-card { width: 150px; border-radius: 6px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .color-display { height: 80px; }
        .color-info { padding: 10px; }
        .color-name { font-weight: bold; margin-bottom: 5px; }
        .color-value { font-family: monospace; font-size: 12px; }
        h2 { margin-top: 30px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
      </style>
    </head>
    <body>
      <h1>NixOS Color Palette</h1>

      <h2>Base Colors</h2>
      <div class="color-grid">
        ${lib.concatMapStrings (name:
          let
            color = colors.colors.${name};
            hsl = "hsl(${toString color.h}, ${toString color.s}%, ${toString color.l}%)";
          in ''
            <div class="color-card">
              <div class="color-display" style="background-color: ${hsl}"></div>
              <div class="color-info">
                <div class="color-name">${name}</div>
                <div class="color-value">${hsl}</div>
              </div>
            </div>
          ''
        ) ["primary" "secondary" "accent"]}
      </div>

      <h2>Neutrals</h2>
      <div class="color-grid">
        ${lib.concatMapStrings (name:
          let
            color = colors.colors.${name};
            hsl = "hsl(${toString color.h}, ${toString color.s}%, ${toString color.l}%)";
          in ''
            <div class="color-card">
              <div class="color-display" style="background-color: ${hsl}"></div>
              <div class="color-info">
                <div class="color-name">${name}</div>
                <div class="color-value">${hsl}</div>
              </div>
            </div>
          ''
        ) ["black" "white"]}
      </div>

      <h2>Grayscale</h2>
      <div class="color-grid">
        ${lib.concatMapStrings (shade:
          let
            color = colors.colors.gray.${shade};
            hsl = "hsl(${toString color.h}, ${toString color.s}%, ${toString color.l}%)";
          in ''
            <div class="color-card">
              <div class="color-display" style="background-color: ${hsl}"></div>
              <div class="color-info">
                <div class="color-name">gray-${shade}</div>
                <div class="color-value">${hsl}</div>
              </div>
            </div>
          ''
        ) ["100" "200" "300" "400" "500" "600" "700" "800" "900"]}
      </div>

      ${lib.concatMapStrings (palette:
        if colors.colors ? ${palette} && builtins.isAttrs colors.colors.${palette} && !(builtins.hasAttr "h" colors.colors.${palette}) then
          let
            paletteAttrs = colors.colors.${palette};
            shades = builtins.attrNames paletteAttrs;
            paletteTitle = lib.toUpper (builtins.substring 0 1 palette) + builtins.substring 1 (builtins.stringLength palette - 1) palette;
          in ''
            <h2>${paletteTitle}</h2>
            <div class="color-grid">
              ${lib.concatMapStrings (shade:
                let
                  color = paletteAttrs.${shade};
                  hsl = "hsl(${toString color.h}, ${toString color.s}%, ${toString color.l}%)";
                in ''
                  <div class="color-card">
                    <div class="color-display" style="background-color: ${hsl}"></div>
                    <div class="color-info">
                      <div class="color-name">${palette}-${shade}</div>
                      <div class="color-value">${hsl}</div>
                    </div>
                  </div>
                ''
              ) shades}
            </div>
          ''
        else ""
      ) ["slate" "amber" "salmon" "aquamarine" "emerald" "cream"]}
    </body>
    </html>
  '';
  destination = "/tmp/palette.html";
}
