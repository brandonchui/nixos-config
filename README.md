# NixOS Configuration

This repository contains my NixOS system configuration using Nix flakes.

## Overview

This is a flake-based NixOS configuration for an x86_64-linux system running on VMware. The configuration includes a GNOME desktop environment, development tools, and various programming language toolchains.

## Features

### System Configuration
- **Desktop Environment**: GNOME with GDM display manager
- **Audio**: PipeWire with ALSA and PulseAudio compatibility
- **Networking**: NetworkManager enabled
- **Virtualization**: VMware guest tools enabled (Windows VM support)
- **Boot Loader**: GRUB with OS prober

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

1. Ensure you have Nix with flakes enabled
2. Clone this repository
3. Run the system rebuild:
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

### Currently Supported
- **VMware**: Full guest tools integration for Windows VMs

### TODO
- [ ] Add Parallels support for macOS VMs

## File Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependencies
├── hardware-configuration.nix # Hardware-specific configuration
└── README.md                # This file
```

## Notes

- System state version: 25.05
- Home Manager state version: 25.05
- Experimental features enabled: `nix-command`, `flakes`
- Default git branch set to: `master`