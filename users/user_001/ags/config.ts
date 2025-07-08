export const config = {
  bar: {
    position: "top" as const,
    height: 40,
    margins: {
      top: 5,
      left: 5,
      right: 5,
      bottom: 0,
    },
    exclusive: true,
  },
  workspaces: {
    count: 10,
    showIcons: false,
    activeClass: "active",
    occupiedClass: "occupied",
    emptyClass: "empty",
  },
  clock: {
    format: "%H:%M",
    interval: 1000,
  },
  systemTray: {
    iconSize: 16,
    spacing: 8,
  },
};
