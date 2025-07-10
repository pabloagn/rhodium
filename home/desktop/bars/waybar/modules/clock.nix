{
  waybarModules = {
    clock = {
      interval = 1;
      format = "{:%H.%M.%S}";
      format-alt = "{:%A, %B %d, %Y | %R} ";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#E6C384'><b>{}</b></span>";
          days = "<span color='#C5C9C7'><b>{}</b></span>";
          weeks = "<span color='#7AA89F'><b>W{}</b></span>";
          weekdays = "<span color='#c4b28a'><b>{}</b></span>";
          today = "<span color='#E46876'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        on-click-left = "kitty -e calcure";
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "format-alt";
        on-scroll-down = "shift_down";
      };
    };
  };
}
