{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Terraform ---
    terraform-ls
  ];
}
