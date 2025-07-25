{
  waybarModules = {
    "custom/vpn" = {
      interval = 1;
      exec = "$XDG_BIN_HOME/waybar/custom-vpn.sh";
      # tooltip = true;
      # tooltip-format = "⊫ VPN\n━━━━━━━━━━━━━━━━━━\n⊫ ⟶ Active\n⊯ ⟶ Inactive";
      # TODO: Eventually the left click will be quick connect/disconnect and right click protonvpn-app
      on-click = "protonvpn-app";
      # on-right-click = "pr";
    };
  };
}
