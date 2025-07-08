import Tray from "gi://AstalTray";
import { createBinding } from "ags";

export default function SystemTray() {
  const tray = Tray.get_default();
  const items = createBinding(tray, "items");

  return (
    <box class="system-tray">
      {items((trayItems) =>
        trayItems.map((item) => (
          <button
            class="tray-item"
            onClicked={() => item.activate(0, 0)}
            onSecondaryClick={(self) => {
              const menu = item.create_menu();
              if (menu) {
                menu.popup_at_widget(
                  self,
                  Gdk.Gravity.SOUTH,
                  Gdk.Gravity.NORTH,
                  null,
                );
              }
            }}
          >
            <icon gicon={createBinding(item, "gicon")} />
          </button>
        )),
      )}
    </box>
  );
}
