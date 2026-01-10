{ lib, ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      identityFile = [ "~/.ssh/GitHub_NixOS" ];
    };
  };

  home.activation.installAuthorizedKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # ensure ~/.ssh directory exists with correct perms
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"

        # write authorized_keys
        cat > "$HOME/.ssh/authorized_keys" <<'EOF'
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/+Hg09diBGpEHR9Mv48P3eXB2sTyarDkHaoCdRTpMWwc96l8LWDAe12yOMmnovN+Q7JxaI+5kKZnD92pXLmNcxLf7YC4IkuD9+FbdmTOOFlyS085Au+j0E9duGl8oPAki+siuXO66WccLRws8zELOb+z0CrlVwZZYR+CWtVNPWXPiguzihigfn4XsgCRfyiB6PxKEmjuwdNzFgbhU+nOsu0H9faEwhFp2bd8s7cV6/0alfSEwdCBrHsXU/izohCfNxSH6DyvInWuTmRXsEn4cIEI2WLZhHGt0KOQwFPtAVRwoj7cwTTH23mkI/u8yfR3g4FuToETBou9hrqB6UGsUTTE4rBZt8i3o0jnfDOqij0jzEysNGJH+1cJGO4jrqGbcKgHc2fZMslFwkd6mXaFk4k74L/Jvd07Q6nH26TsZgC7f9+nmCRVjmX7fpRhpZnGuvYediKRC874Q+4WAfgzreU3Ac06E++q0KvOZMwlHDvAJz+djwnMImG7X1EYzhK0= pabloagn@nixos
    EOF

        # set proper ownership and perms
        chown "$USER":"$(id -gn $USER)" "$HOME/.ssh/authorized_keys"
        chmod 600 "$HOME/.ssh/authorized_keys"
  '';
}
