# Hardware configuration for Parallels VM on ARM64 Mac
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  # ARM64-specific kernel modules for Parallels
  boot.initrd.availableKernelModules = [ "virtio_pci" "virtio_scsi" "virtio_blk" "virtio_net" "ahci" "xhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-arm" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bb881e67-4dd2-4e18-856b-9e7b71bb525a";
      fsType = "ext4";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  # Set the platform to ARM64
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  # Parallels-specific optimizations (commented out for VMware)
  # services.spice-vdagentd.enable = false;
  # virtualisation.hypervGuest.enable = false;
}