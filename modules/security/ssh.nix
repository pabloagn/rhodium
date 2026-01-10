{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
    };
  };

  programs.ssh = {
    startAgent = true;
  };

  # Disable gcr-ssh-agent to avoid conflict with programs.ssh.startAgent
  # (gcr-ssh-agent is auto-enabled by programs.niri via gnome-keyring)
  services.gnome.gcr-ssh-agent.enable = false;
}
