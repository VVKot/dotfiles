{
  description = "Home Manager configuration of kot";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    homeConfigurations = {
      kot = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-darwin";
        };
        modules = [
          ./home-manager/home.nix
          ./home-manager/rust-dev.nix
          ./home-manager/writing.nix
        ];
        extraSpecialArgs = {
          vars = {
            username = "kot";
            home = "/Users";
          };
        };
      };

      vkot = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
        modules = [
          ./home-manager/big-data.nix
          ./home-manager/home.nix
          ./home-manager/kubernetes-dev.nix
          ./home-manager/writing.nix
        ];
        extraSpecialArgs = {
          vars = {
            username = "vkot";
            home = "/Users";
          };
        };
      };
    };
  };
}
