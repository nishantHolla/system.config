{
    description = "Flake file for my nixos system";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        inputs@{self, nixpkgs, home-manager, ...}:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {

            # ---------------- System configuration ------------------

            nixosConfigurations.nixosPavilion = nixpkgs.lib.nixosSystem {
                modules = [
                    ./nixos/nixosPavilion/config.nix
                    ./nixos/nixosPavilion/packages.nix
                    ./nixos/nixosPavilion/hardware.nix
                ];
            };

            # ---------------- Home configuration ------------------

            homeConfigurations."nishant" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                modules = [
                    ./home-manager/nishant/home.nix
                    ./home-manager/nishant/packages.nix
                ];
            };
        };
}
