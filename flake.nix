{
  description = "Prototype build";

  inputs = {
    # Core inputs.
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    # Component-specific inputs.
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, nixpkgs, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, ... }: {
        formatter = pkgs.alejandra;
      };

      # The `flake` is made up of 2 variables: `nixosConfigurations` & `homeConfigurations`.
      # 
      # `homeConfigurations` was causing a recursion loop; documentation suggest using nixosModules.
      # Correct modularisation still needed.
      flake = {
        # Hardware & system settings.
        nixosConfigurations = {
          relay = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs.inputs = inputs;
            modules = [
              ./machines/nucbox-k10.nix
              ./core
      	      ./users/roles.nix
      	      home-manager.nixosModules.home-manager {
      	        home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
            		  backupFileExtension = "backup";
                  users.kv.imports = [ ./users/kv ];
                  extraSpecialArgs.inputs = inputs;
            		};
      	      }
            ];
          };

          laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./machines/acer-aspire-vero.nix
              ./core
            ];
          };
        };
      };
    };
}
