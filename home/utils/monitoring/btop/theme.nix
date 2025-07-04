{...}: {
  programs.btop.themes = {
    chiaroscuro = ''
      # Main background, empty for terminal default, need to be empty if you want transparent background
      theme[main_bg]="#090E13"

      # Main text color
      theme[main_fg]="#C5C9C7"

      # Title color for boxes
      theme[title]="#C5C9C7"

      # Highlight color for keyboard shortcuts
      theme[hi_fg]="#7FB4CA"

      # Background color of selected item in processes box
      theme[selected_bg]="#393B44"

      # Foreground color of selected item in processes box
      theme[selected_fg]="#7FB4CA"

      # Color of inactive/disabled text
      theme[inactive_fg]="#717C7C"

      # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
      theme[graph_text]="#oldWhite"

      # Background color of the percentage meters
      theme[meter_bg]="#22262D"

      # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
      theme[proc_misc]="#oldWhite"

      # CPU, Memory, Network, Proc box outline colors
      theme[cpu_box]="#938AA9"
      theme[mem_box]="#98BB6C"
      theme[net_box]="#E46876"
      theme[proc_box]="#7FB4CA"

      # Box divider line and small boxes line color
      theme[div_line]="#393B44"

      # Temperature graph color
      theme[temp_start]="#98BB6C"
      theme[temp_mid]="#E6C384"
      theme[temp_end]="#E46876"

      # CPU graph colors
      theme[cpu_start]="#7AA89F"
      theme[cpu_mid]="#7FB4CA"
      theme[cpu_end]="#938AA9"

      # Mem/Disk free meter
      theme[available_start]="#fab387"
      theme[available_mid]="#eba0ac"
      theme[available_end]="#f38ba8"

      # Mem/Disk cached meter
      theme[cached_start]="#7FB4CA"
      theme[cached_mid]="#7AA89F"
      theme[cached_end]="#6A9589"

      # Mem/Disk available meter
      theme[available_start]="#fab387"
      theme[available_mid]="#eba0ac"
      theme[available_end]="#f38ba8"

      # Mem/Disk used meter
      theme[used_start]="#98BB6C"
      theme[used_mid]="#7AA89F"
      theme[used_end]="#6A9589"

      # Download graph colrs
      theme[download_start]="#fab387"
      theme[download_mid]="#eba0ac"
      theme[download_end]="#f38ba8"

      # Upload graph colors
      theme[upload_start]="#a6e3a1"
      theme[upload_mid]="#94e2d5"
      theme[upload_end]="#89dceb"

      # Process box color gradient for threads, mem and cpu usage
      theme[process_start]="#7FB4CA"
      theme[process_mid]="#938AA9"
      theme[process_end]="#717C7C"
    '';
  };
}
