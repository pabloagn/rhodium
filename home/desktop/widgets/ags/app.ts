import Gtk from "gi://Gtk?version=4.0";
import Gdk from "gi://Gdk?version=4.0";
import GLib from "gi://GLib";
import { Application } from "gi://AstalIO";
import Window from "gi://Astal4";

import clock from "./widgets/clock.js";
import battery from "./widgets/battery.js";

// 🧠 Load CSS
const cssProvider = new Gtk.CssProvider();
cssProvider.load_from_path(
  GLib.build_filenamev([GLib.get_current_dir(), "styles/style.css"]),
);
Gtk.StyleContext.add_provider_for_display(
  Gdk.Display.get_default(),
  cssProvider,
  Gtk.STYLE_PROVIDER_PRIORITY_USER,
);

const app = new Application();

app.on("activate", () => {
  // --- Clock Widget Window (top Left) ---
  const win = new Window();
  win.set_decorated(false);
  win.set_resizable(false);
  win.set_size_request(200, 50);
  win.move(10, 10);
  win.set_child(clock());
  win.present();

  // --- Battery Widget Window (bottom Left) ---
  const win2 = new Window();
  win2.set_decorated(false);
  win2.set_resizable(false);
  win2.set_size_request(200, 50);
  win2.move(10, 500);
  win2.set_child(battery());
  win2.present();
});

app.run([]);
