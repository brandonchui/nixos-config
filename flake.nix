{
  description = "NixOS configuration (flake-only)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-config.url = "github:brandonchui/helix_settings/HEAD";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, helix-config, home-manager, zig, ... }:
  let
    unstablePkgs = import nixpkgs-unstable{
      system ="aarch64-linux" ;
      config.allowUnfree = true;
    };
    overlays = [
      (final: prev:
        {
          helix = unstablePkgs.helix;
          claude-code = unstablePkgs.claude-code;
        })
    ];
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        ({ config, pkgs, ... }: {
          # Apply the overlay to nixpkgs
          nixpkgs.overlays = overlays;
          
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.bchui = { ... }: {
            imports = [helix-config.homeManagerModules.default];
            # programs.helix.extraPackages = [
            #   unstablePkgs.tree-sitter-cpp
            # ];
            programs.git = {
              enable = true;
              userName = "brandonchui";
              userEmail = "chuib@usc.edu";
              extraConfig = {
                init.defaultBranch = "master";
              };
            };
            home.stateVersion = "25.05";
          };
          
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          # Use systemd-boot for ARM64 instead of GRUB
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          networking.hostName = "nixos";
          networking.networkmanager.enable = true;
          time.timeZone = "America/Los_Angeles";
          services.xserver.enable = true;
          services.xserver.displayManager.gdm.enable = true;
          services.xserver.desktopManager.gnome.enable = true;
          services.printing.enable = true;
          hardware.pulseaudio.enable = false;
          security.rtkit.enable = true;
          services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
          };
          users.users.bchui = {
            isNormalUser = true;
            description = "Brandon Chui";
            extraGroups = [ "networkmanager" "wheel" ];
          };
          programs.firefox.enable = true;
          nixpkgs.config.allowUnfree = true;
          environment.systemPackages = with pkgs; [
            linuxPackages.perf
            helix
            git
            meson
            jujutsu
            clang
            clang-tools
            gcc
            ninja
            cmake
            ghostty
            xclip
            boost
            lazygit
            # Parallels guest tools not needed in package list
            zig.packages.${system}.master
            zls
            gnumake
            wget
            zellij
            bash
            claude-code
            ocamlPackages.ocaml
            ocamlPackages.dune_3
            ocamlPackages.findlib
            ocamlPackages.utop
            ocamlPackages.odoc
            ocamlPackages.ocaml-lsp
            dune-release
            ocamlPackages.base
            ocamlPackages.menhir
            ocamlformat
            # core rust
            rustc
            cargo
            rustfmt
            clippy
            rust-analyzer
            # link
            mold
            #cargo stuff
            cargo-watch
            python314
          ];
          environment.variables.EDITOR = "hx";
          # Enable Parallels guest support for better integration
          hardware.parallels.enable = true;
          # Apprently we do not neeed this anymore
          # hardware.parallels.autoMountShares = true;
          system.stateVersion = "25.05";
        })
      ];
    };
  };
}

