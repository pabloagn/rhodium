{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Terraform ---
    terraform
    terraform-ls # Official language server

    # --- Kubernetes TUI ---
    k9s # Kubernetes TUI management
    kdash # Simple and fast Kubernetes dashboard

    # --- Docker TUI ---
    lazydocker # Docker management TUI
    dive # Docker image layer analysis
    ctop # Top-like interface for containers
  ];
}
