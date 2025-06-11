{ ... }:

{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/GitHub_NixOS
    '';
  };
}
