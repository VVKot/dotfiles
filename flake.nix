{
  description = "NixOS configuration of kot";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nix-darwin,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      future = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/future/configuration.nix
          nixos-hardware.nixosModules.framework-intel-core-ultra-series1
        ];
        specialArgs = {
          inherit home-manager;
        };
      };
    };

    darwinConfigurations = {
      bigapple = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/bigapple/configuration.nix
        ];
        specialArgs = {
          inherit self home-manager;
        };
      };
    };

    homeManagerModules = {
      home = ./modules/home-manager/home.nix;
      kubernetes-dev = ./modules/home-manager/kubernetes-dev.nix;
      rust-dev = ./modules/home-manager/rust-dev.nix;
      writing = ./modules/home-manager/writing.nix;
    };
  };
}
