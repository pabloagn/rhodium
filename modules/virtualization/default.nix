# modules/virtualization/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    # QEMU/KVM & Libvirt Ecosystem
    {
      name = "virt-manager";
      pkg = pkgs.virt-manager;
      description = "Desktop user interface for managing virtual machines through libvirt.";
    }
    {
      name = "qemu";
      pkg = pkgs.qemu;
      description = "A generic and open source machine emulator and virtualizer.";
    }
    {
      name = "libvirt";
      pkg = pkgs.libvirt;
      description = "Virtualization API for Linux";
    }
    # Docker Ecosystem
    {
      name = "docker-compose";
      pkg = pkgs.docker-compose;
      description = "Docker Compose: Define and run multi-container applications with Docker";
    }
    {
      name = "portainer";
      pkg = pkgs.portainer;
      description = "Portainer: A simple management UI for Docker";
    }
    # Kubernetes Ecosystem
    {
      name = "kubectl";
      pkg = pkgs.kubectl;
      description = "Kubernetes command-line tool";
    }
    {
      name = "k9s";
      pkg = pkgs.k9s;
      description = "Interactive kubernetes CLI";
    }
    {
      name = "helm";
      pkg = pkgs.helm;
      description = "Kubernetes package manager";
    }
    {
      name = "minikube";
      pkg = pkgs.minikube;
      description = "Kubernetes locally";
    }
    {
      name = "kind";
      pkg = pkgs.kind;
      description = "Kubernetes IN Docker";
    }
    {
      name = "k3s";
      pkg = pkgs.k3s;
      description = "Lightweight Kubernetes";
    }
    {
      name = "k3d";
      pkg = pkgs.k3d;
      description = "Kubernetes distributed";
    }
    # Podman Ecosystem
    {
      name = "podman";
      pkg = pkgs.podman;
      description = "Podman: A tool for managing OCI containers and pods";
    }
    {
      name = "podman-compose";
      pkg = pkgs.podman-compose;
      description = "Podman Compose: A tool for managing OCI containers and pods";
    }
    {
      name = "buildah";
      pkg = pkgs.buildah;
      description = "A tool that facilitates building OCI (Open Container Initiative) compliant containers";
    }
    {
      name = "skopeo";
      pkg = pkgs.skopeo;
      description = "A tool for managing OCI (Open Container Initiative) compliant containers";
    }
    # LXC/LXD/Incus Ecosystem
    {
      name = "lxc";
      pkg = pkgs.lxc;
      description = "LXC: Linux Containers";
    }
    {
      name = "lxd";
      pkg = pkgs.lxd;
      description = "LXD: Linux Containers";
    }
    {
      name = "incus";
      pkg = pkgs.incus;
      description = "Incus: Linux Containers";
    }
    # Virtual Machine & Environment Management
    {
      name = "vagrant";
      pkg = pkgs.vagrant;
      description = "Vagrant: A tool for building and managing virtual machine environments in a single workflow";
    }
    {
      name = "packer";
      pkg = pkgs.packer;
      description = "Packer: A tool for building and managing virtual machine images";
    }
    # VirtualBox
    {
      name = "virtualbox";
      pkg = pkgs.virtualbox;
      description = "VirtualBox: A powerful x86 and AMD64 virtualization product for enterprise as well as home use";
    }
    # Proxmox
    {
      name = "proxmox";
      pkg = pkgs.proxmox-ve;
      description = "Proxmox Virtual Environment";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configurations" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    environment.systemPackages = rhodiumLib.getEnabledPackages cfg packageSpecs;
    docker.enable = false;
  };
}
