{pkgs, ...}: {
  home.packages = with pkgs; [
    # --- Terraform ---
    terraform
    terraform-ls # Official language server
  ];
}
