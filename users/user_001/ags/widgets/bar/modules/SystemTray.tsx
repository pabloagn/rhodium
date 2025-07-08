import SystemTray from "gi://AstalTray"
import { bind } from "astal"
import { config } from "../../../config"

export function SystemTray() {
    const tray = SystemTray.get_default()
    
    return (
        <box className="system-tray" spacing={config.systemTray.spacing}>
            {bind(tray, "items").as(items => 
                items.map(item => (
                    <button
                        key={item.id}
                        className="tray-item"
                        onClicked={() => item.activate(0, 0)}
                        tooltipMarkup={bind(item, "tooltip_markup")}
                    >
                        <icon
                            gicon={bind(item, "gicon")}
                            pixbuf={bind(item, "icon_pixbuf")}
                            iconName={bind(item, "icon_name")}
                            size={config.systemTray.iconSize}
                        />
                    </button>
                ))
            )}
        </box>
    )
}
