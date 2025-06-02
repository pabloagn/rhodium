{ pkgs, users, ... }:
let
  user_001_data = users.user_001 or {
    username = "user";
    fullName = "Default User";
    email = "user@example.com";
    description = "Default User";
    extraGroups = [ "wheel" ];
  };
in
{
  users.users."${user_001_data.username}" = {
    isNormalUser = user_001_data.isNormalUser or true;
    description = user_001_data.description;
    extraGroups = user_001_data.extraGroups;
    # shell = pkgs.zsh;
    shell = pkgs.fish;
    home = "/home/${user_001_data.username}";
    # hashedPassword = user_001_data.hashedPassword or null;
    # initialPassword = user_001_data.initialPassword or null;
  };

  # Default shell for all users
  users.defaultUserShell = pkgs.zsh;
}
