{...}: {
  programs.zed-editor = {
    userSettings = {
      theme = {
        mode = "system";
        # dark = "Kanso Zen (Blurred)";
        # TODO: Fix the out of focus top bar. Current gray is uggly AF.
        # light = "Kanso Pearl (Blurred)";
        dark = "Kanso Zen (Borderless)";
        light = "Kanso Pearl (Borderless)";
      };
      icon_theme = "Catppuccin Mocha";
    };
  };
}
