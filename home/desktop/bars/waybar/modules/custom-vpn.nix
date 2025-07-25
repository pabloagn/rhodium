{
  waybarModules = {
    "custom/vpn" = {
      interval = 5;
      exec = "pgrep -a openvpn|grep -q tun && echo '' || echo ''";
      tooltip = true;
      tooltip-format = "⊫ VPN\n━━━━━━━━━━━━━━━━━━\n⊫ ⟶ Active\n⊯ ⟶ Inactive";
      on-click = "kitty -e nmtui";
      on-right-click = "protonvpn-app";
    };
  };
}
