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
    nixosConfigurations = {
      hubbabubba = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/hubbabubba/configuration.nix
        ];
        specialArgs = {
          inherit home-manager;
        };
      };
    };

    homeConfigurations = {
      coder = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./modules/home-manager/home.nix
          ./modules/home-manager/kubernetes-dev.nix
          ./modules/home-manager/rust-dev.nix
        ];
        extraSpecialArgs = {
          vars = {
            username = "coder";
            home = "/home";
            homebrewPrefix = "/home/linuxbrew/.linuxbrew";
          };
        };
      };

      kot = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-darwin";
        };
        modules = [
          ./modules/home-manager/home.nix
          ./modules/home-manager/rust-dev.nix
          ./modules/home-manager/writing.nix
        ];
        extraSpecialArgs = {
          vars = {
            username = "kot";
            home = "/Users";
            homebrewPrefix = "/usr/local";
          };
        };
      };

      vkot = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
        modules = [
          ./modules/home-manager/big-data.nix
          ./modules/home-manager/home.nix
          ./modules/home-manager/kubernetes-dev.nix
          ./modules/home-manager/writing.nix
        ];
        extraSpecialArgs = {
          vars = {
            username = "vkot";
            home = "/Users";
            homebrewPrefix = "/opt/homebrew";
          };
        };
      };
    };
  };
}
