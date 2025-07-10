{
  bluetooth = {
    format = " {num_connections} {status}";
    format-disabled = "0 ▽";
    format-off = "0 ▼";
    format-on = "0 △";
    format-connected = "{num_connections} ▲";
    tooltip = true;
    tooltip-format = ''
      ⋊ Bluetooth
      ━━━━━━━━━━━━━━━━━━
      • {controller_alias} ⟶ {controller_address}
      • {num_connections} connected
    '';
    tooltip-format-connected = ''
      ⋊ Bluetooth
      ━━━━━━━━━━━━━━━━━━
      • {controller_alias} ⟶ {controller_address}

      • {device_enumerate}
    '';
    tooltip-format-enumerate-connected = "↳ {device_alias} [{device_address}]";
    tooltip-format-enumerate-connected-battery = "↳ {device_alias} [{device_address}] ⦚ {device_battery_percentage}%";
    on-click = "$XDG_BIN_HOME/fuzzel/fuzzel-bluetooth.sh";
    on-click-right = "blueman-manager";
  };
}

