{ pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    config = {
      user.name = user.fullName;
      user.email = user.email;
      init.defaultBranch = "main";
    };
  };
}
