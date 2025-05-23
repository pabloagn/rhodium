# home/development/ides/vscode/themes.nix

# TODO: Later we inject themes from assets as with helix, etc.

{ lib }:

let
  themes = {
    tokyo-night = {
      workbench = {
        "workbench.colorTheme" = "Tokyo Night";
        "workbench.iconTheme" = "material-icon-theme";
      };
      colors = {
        "workbench.colorCustomizations" = {
          "[Tokyo Night]" = {
            "editor.background" = "#141518";
            "editor.lineHighlightBackground" = "#1f2233";
            "editor.selectionBackground" = "#24282f";
            "editor.findMatchBackground" = "#2e3c57";
            "editorWhitespace.foreground" = "#3b4048";
            "editorCursor.foreground" = "#d9dee8";
            "editorIndentGuide.background1" = "#232530";
            "editorIndentGuide.activeBackground1" = "#393b4d";
            "sideBar.background" = "#141518";
            "sideBar.foreground" = "#abb2bf";
            "sideBarTitle.foreground" = "#abb2bf";
            "sideBarSectionHeader.background" = "#181a1f";
            "sideBarSectionHeader.foreground" = "#abb2bf";
            "activityBar.background" = "#141518";
            "activityBar.foreground" = "#cbc2c4";
            "activityBar.inactiveForeground" = "#9794a3";
            "titleBar.activeBackground" = "#141518";
            "titleBar.activeForeground" = "#a9adb1";
            "activityBarBadge.background" = "#d4b89b";
            "activityBarBadge.foreground" = "#1a1b26";
            "statusBar.background" = "#141518";
            "statusBar.foreground" = "#9794a3";
            "editorGroupHeader.tabsBackground" = "#141518";
            "editorGroupHeader.tabsBorder" = "#141518";
            "tab.activeBackground" = "#141518";
            "tab.activeForeground" = "#d0d9e6";
            "tab.inactiveBackground" = "#13141c";
            "tab.inactiveForeground" = "#8792aa";
            "tab.activeBorder" = "#8792aa";
            "breadcrumb.background" = "#141518";
            "breadcrumb.foreground" = "#8792aa";
            "breadcrumb.focusForeground" = "#d5d8da";
            "breadcrumb.activeSelectionForeground" = "#ffffff";
            "breadcrumbPicker.background" = "#1c1e26";
            "list.activeSelectionBackground" = "#1e2126";
            "list.activeSelectionForeground" = "#d0d9e6";
            "list.inactiveSelectionBackground" = "#1c1f25";
            "list.hoverBackground" = "#1c1f25";
            "scrollbarSlider.background" = "#2a2c3a80";
            "scrollbarSlider.hoverBackground" = "#3b3f5280";
            "scrollbarSlider.activeBackground" = "#3b3f52";
          };
        };
      };
      syntax = {
        "editor.tokenColorCustomizations" = {
          "[Tokyo Night]" = {
            "textMateRules" = [
              {
                "scope" = "variable.other.rust";
                "settings" = {
                  "foreground" = "#e7d721";
                };
              }
            ];
          };
        };
      };
    };

    catppuccin-mocha = {
      workbench = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
      };
      colors = {
        "workbench.colorCustomizations" = {
          "[Catppuccin Mocha]" = {
            "editor.background" = "#1e1e2e";
            "sideBar.background" = "#181825";
            "activityBar.background" = "#11111b";
            # Add more Catppuccin colors as needed
          };
        };
      };
      syntax = {
        "editor.tokenColorCustomizations" = {
          "[Catppuccin Mocha]" = {
            "textMateRules" = [ ];
          };
        };
      };
    };
  };

in
{
  # Export theme definitions
  inherit themes;

  # Function to get theme settings
  getTheme = themeName: themes.${themeName} or themes.tokyo-night;

  # Function to merge theme components
  getThemeSettings = themeName:
    let theme = themes.${themeName} or themes.tokyo-night;
    in lib.mkMerge [
      theme.workbench
      theme.colors
      theme.syntax
    ];
}
