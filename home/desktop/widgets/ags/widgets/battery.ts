import Gtk from "gi://Gtk?version=4.0";
import Battery from "gi://AstalBattery";

export default function battery(): Gtk.Widget {
  const battery = new Battery();
  const label = new Gtk.Label({
    label: `Battery: ${battery.level}%`,
  });

  battery.connect("changed", () => {
    label.label = `Battery: ${battery.level}%`;
  });

  const box = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL });
  box.append(label);
  return box;
}

