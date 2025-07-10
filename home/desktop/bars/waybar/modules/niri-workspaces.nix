{
  waybarModules = {
    "niri/workspaces" = {
      format = "●";
      on-click = "activate";
      on-scroll-up = "niri msg action focus-workspace-up";
      on-scroll-down = "niri msg action focus-workspace-down";
      smooth-scrolling-threshold = 2.0;
    };
  };
}
