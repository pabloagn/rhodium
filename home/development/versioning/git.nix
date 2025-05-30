{ pkgs, user, ... }:
let
  userfullName = user.fullName;
  userEmail = user.emailMain;
in
{
  programs.git = {
    enable = true;
    delta = {
      enable = true;
    };
    config = {
      user.name = userfullName;
      user.email = userEmail;
      init.defaultBranch = "main";
    };
  };
}
