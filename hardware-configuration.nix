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
    { device = "/dev/disk/by-uuid/2ec7e152-3d46-44b3-b9f5-ddb91e181a03";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/657A-18CE";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  # Set the platform to ARM64
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  
  # Parallels-specific optimizations
  services.spice-vdagentd.enable = false;
  virtualisation.hypervGuest.enable = false;
}