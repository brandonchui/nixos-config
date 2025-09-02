# NixOS Configuration

This repository contains my NixOS system configuration using Nix flakes.

## Overview

This repository contains NixOS configurations for multiple platforms:
- **main branch**: x86_64-linux system running on VMware
- **parallels-mac-arm branch**: aarch64-linux (ARM64) system running on Parallels for Mac

Both configurations include a GNOME desktop environment, development tools, and various programming language toolchains.

## Features

### System Configuration
- **Desktop Environment**: GNOME with GDM display manager
- **Audio**: PipeWire with ALSA and PulseAudio compatibility
- **Networking**: NetworkManager enabled
- **Virtualization**: 
  - VMware guest tools (main branch)
  - Parallels guest tools (parallels-mac-arm branch)
- **Boot Loader**: 
  - GRUB with OS prober (x86_64)
  - systemd-boot (ARM64)

### Development Environment
- **Editor**: Helix (from unstable channel) with custom configuration
- **Terminal**: Ghostty, Zellij
- **Version Control**: Git, Lazygit

### Programming Languages & Tools
- **C/C++**: Clang, GCC, CMake, clang-tools
- **Rust**: rustc, cargo, rustfmt, clippy, rust-analyzer, cargo-watch
- **Zig**: Master branch overlay, ZLS
- **OCaml**: Full toolchain with Dune, utop, LSP, and various packages
- **Other**: Make, wget, bash

### Flake Inputs
- `nixpkgs`: NixOS 25.05
- `nixpkgs-unstable`: For newer packages (Helix, Claude Code)
- `home-manager`: User-specific configuration management
- `helix-config`: Custom Helix editor settings
- `zig`: Zig overlay for master branch

## Installation

### For VMware (x86_64) - main branch
1. Clone this repository
2. Run the system rebuild:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

### For Parallels on Mac (ARM64) - parallels-mac-arm branch
1. Clone this repository and checkout the ARM branch:
   ```bash
   git clone https://github.com/brandonchui/nixos-config.git
   cd nixos-config
   git checkout parallels-mac-arm
   ```
2. Apply the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## User Configuration

The primary user `bchui` is configured with:
- Home Manager integration
- Git configuration (username: brandonchui, email: chuib@usc.edu)
- Custom Helix configuration from external repository
- Sudo access via wheel group

## VM Support

- **VMware** (main branch): Full guest tools integration for x86_64 systems
- **Parallels** (parallels-mac-arm branch): Full guest tools integration for ARM64 Mac systems

## File Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependencies
├── hardware-configuration.nix # Hardware-specific configuration
└── README.md                # This file
```

## Notes

- NixOS version: 25.05
- System state version: 25.05
- Home Manager state version: 25.05
- Experimental features enabled: `nix-command`, `flakes`
- Default git branch set to: `master`

## Platform-Specific Notes

### ARM64 (Parallels Mac)
- Uses systemd-boot instead of GRUB for better ARM64 UEFI support
- Hardware configuration includes ARM-specific kernel modules
- Parallels guest tools enabled for clipboard sharing and folder mounting