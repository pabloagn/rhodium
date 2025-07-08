import Gtk from "gi://Gtk?version=4.0";

export default function clock(): Gtk.Widget {
  const label = new Gtk.Label({
    label: new Date().toLocaleTimeString(),
  });

  // Optional: auto-update every second
  setInterval(() => {
    label.label = new Date().toLocaleTimeString();
  }, 1000);

  const box = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL });
  box.append(label);
  return box;
}

