{...}: {
  # Get icon without formatting
  getIcon = iconPath: fallback:
    iconPath.char or fallback;

  # Format icon with trailing space for starship/terminal use
  formatIcon = iconPath: fallback: "${iconPath.char or fallback} ";
}
