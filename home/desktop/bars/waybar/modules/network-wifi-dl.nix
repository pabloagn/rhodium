{
  waybarModules = {
    "network#wifi-dl" = {
      interval = 1;
      format-wifi = "{bandwidthDownBytes:>} ↓";
      format-linked = "≏ No IP";
      format-disconnected = "⌽";
      tooltip = false;
    };
  };
}
