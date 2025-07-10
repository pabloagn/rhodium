{
  "group/wifi-speed" = {
    orientation = "horizontal";
    drawer = {
      transition-duration = 300;
      children-class = "drawer-hidden";
      click-to-reveal = false;
      transition-left-to-right = true;
    };
    modules = ["network#wifi-dl" "network#wifi-ul"];
  };
}
