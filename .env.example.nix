# ./env.example.nix
# Example environment variables for the Rhodium system

{ pkgs, ... }:

{
  users = {
    "user-0001" = {
      id = "0001";
      username = "username";
      fullName = "Name Surname";
      email = "email@example.com";
      gitUsername = "git-username";
      gitEmail = "git-email@example.com";
      shell = pkgs.zsh;
      groups = [ "groups" ];
      extraGroups = [ "groups" ];
      isNormalUser = true;
      hostGroups = [ "hosts-01" ];
    };

    "user-0002" = {
      id = "0002";
      username = "username";
      fullName = "Name Surname";
      email = "email@example.com";
      gitUsername = "git-username";
      gitEmail = "git-email@example.com";
      shell = pkgs.zsh;
      groups = [ "groups" ];
      extraGroups = [ "groups" ];
      isNormalUser = true;
      hostGroups = [ "hosts-02" ];
    };
  };

  hosts = {
    "host-0001" = {
      id = "0001";
      hostname = "hostname";
      platform = "platform";
      locale = "locale";
      timeZone = "time-zone";
      keymap = "keymap";
      keyboardLayout = "keyboard-layout";
      memberOfGroups = [ "hosts-01" ];
    };

    "host-0002" = {
      id = "0002";
      hostname = "hostname";
      platform = "platform";
      locale = "locale";
      timeZone = "time-zone";
      keymap = "keymap";
      keyboardLayout = "keyboard-layout";
      memberOfGroups = [ "hosts-02" ];
    };

    "host-0003" = {
      id = "0003";
      hostname = "hostname";
      platform = "platform";
      locale = "locale";
      timeZone = "time-zone";
      keymap = "keymap";
      keyboardLayout = "keyboard-layout";
      memberOfGroups = [ "hosts-01" "hosts-02" ];
    };
  };
}
