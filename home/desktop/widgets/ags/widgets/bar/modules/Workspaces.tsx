import { createState } from "ags";
import { subprocess } from "ags/process";

export default function Workspaces() {
  const [activeWorkspace, setActiveWorkspace] = createState(1);
  const [workspaces, setWorkspaces] = createState([1, 2, 3, 4, 5]);

  // Monitor Niri workspace changes
  subprocess(["niri", "msg", "-j", "event-stream"], (out) => {
    try {
      const event = JSON.parse(out);
      if (event.WorkspaceSwitched) {
        setActiveWorkspace(event.WorkspaceSwitched.idx + 1);
      }
    } catch (e) {}
  });

  const switchWorkspace = (id: number) => {
    subprocess(["niri", "msg", "action", "focus-workspace", String(id)]);
  };

  return (
    <box class="workspaces">
      {workspaces((wsList) =>
        wsList.map((id) => (
          <button
            class={activeWorkspace((active) =>
              active === id ? "workspace active" : "workspace",
            )}
            onClicked={() => switchWorkspace(id)}
          >
            <label label={String(id)} />
          </button>
        )),
      )}
    </box>
  );
}
