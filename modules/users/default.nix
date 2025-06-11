{ pkgs, users, ... }:

let
  user_001_data =
    users.user_001 or {
      username = "user";
      fullName = "Default User";
      email = "user@example.com";
      description = "Default User";
      extraGroups = [ "wheel" ];
    };
in
{
  users.users."${user_001_data.username}" = {
    name = user_001_data.fullName;
    isNormalUser = user_001_data.isNormalUser or true;
    description = user_001_data.fullName;
    extraGroups = user_001_data.extraGroups;
    shell = pkgs.fish;
    home = "/home/${user_001_data.username}";
  };

  users.defaultUserShell = pkgs.zsh; # Default shell for all users
}
