{
  waybarModules = {
    "custom/vpn" = {
      interval = 1;
      exec = "$XDG_BIN_HOME/waybar/custom-vpn.sh";
      tooltip = true;
      tooltip-format = "⊫ VPN\n━━━━━━━━━━━━━━━━━━\n⊫ ⟶ Active\n⊯ ⟶ Inactive";
      on-click = "kitty -e nmtui";
      on-right-click = "protonvpn-app";
    };
  };
}
