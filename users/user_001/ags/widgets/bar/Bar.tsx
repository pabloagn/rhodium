import { App, Astal, Gtk } from "astal/gtk3"
import { config } from "../../config"
import { Workspaces, Clock, SystemTray } from "./modules"

export default function Bar() {
    const { monitor } = App
    
    return (
        <window
            name="bar"
            className="bar"
            monitor={monitor}
            exclusivity={config.bar.exclusive ? Astal.Exclusivity.EXCLUSIVE : Astal.Exclusivity.NONE}
            anchor={
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT
            }
            marginTop={config.bar.margins.top}
            marginLeft={config.bar.margins.left}
            marginRight={config.bar.margins.right}
            marginBottom={config.bar.margins.bottom}
        >
            <centerbox className="bar-container">
                <box className="bar-left" halign={Gtk.Align.START}>
                    <Workspaces />
                </box>
                
                <box className="bar-center" halign={Gtk.Align.CENTER}>
                    <Clock />
                </box>
                
                <box className="bar-right" halign={Gtk.Align.END}>
                    <SystemTray />
                </box>
            </centerbox>
        </window>
    )
}
