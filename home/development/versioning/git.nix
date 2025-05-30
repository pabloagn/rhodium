{ pkgs, user, ... }:
let
  userfullName = user.fullName;
  userEmail = user.emailMain;
in
{
  programs.git = {
    enable = true;
    userName = userfullName;
    userEmail = userEmail;
    # init.defaultBranch = "main"; # Of course they disappeared this opt, check what we need.
    delta = {
      enable = true;
    };
  };
}
