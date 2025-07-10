{
  waybarModules = {
    disk = {
      interval = 15;
      path = "/";
      format = "⬢ {percentage_used}%";
      format-alt = "⬢ {free} / {total}";
      tooltip = true;
      tooltip-format = ''
        ⬢ Disk Storage
        ━━━━━━━━━━━━━━━━━━
        • Usage ⟶ {used} / {total} ({percentage_used}%)
        • Available ⟶ {free} ({percentage_free}%)
        • Mount Point ⟶ {path}
      '';
      on-click-right = "thunar /";
      states = {
        warning = 70;
        critical = 85;
      };
    };
  };
}
