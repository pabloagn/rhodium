{ ... }:

{
  # Window Rules
  windowrulev2 = [
    "suppressevent maximize, class:.*"
    "workspace special:calculator,class:(qalculate-gtk)"
    "workspace special:calendar,class:(foot|st|alacritty|kitty),title:(calcurse)"
  ];

  # Layer Rules
  # TODO: Check if this is applied correctly (fuzzel animation rule)
  layerrule =
  [
    "noanim, ^(rofi)$"
    "noanim, ^(fuzzel)$"
  ];
}
