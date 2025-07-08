import { Gtk } from "astal/gtk3"
import { config } from "../../../config"
import { range } from "../../../lib/utils"
import { hyprland, activeWorkspace, workspaces } from "../../../services/hyprland"

export function Workspaces() {
    const getWorkspaceClass = (id: number) => {
        const active = activeWorkspace.get()
        const allWorkspaces = workspaces.get()
        
        if (active && active.id === id) {
            return config.workspaces.activeClass
        }
        
        const occupied = allWorkspaces.some(ws => ws.id === id)
        return occupied ? config.workspaces.occupiedClass : config.workspaces.emptyClass
    }
    
    return (
        <box className="workspaces" spacing={4}>
            {range(1, config.workspaces.count + 1).map(i => (
                <button
                    key={i}
                    className={`workspace ${getWorkspaceClass(i)}`}
                    onClicked={() => hyprland.dispatch("workspace", String(i))}
                >
                    <label label={String(i)} />
                </button>
            ))}
        </box>
    )
}
