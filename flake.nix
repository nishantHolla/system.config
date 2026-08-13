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

            nixosConfigurations.nixosVM = nixpkgs.lib.nixosSystem {
                modules = [
                    ./nixos/nixosVM/config.nix
                    ./nixos/nixosVM/packages.nix
                    ./nixos/nixosVM/hardware.nix
                ];
            };

            # ---------------- Home configuration ------------------

            homeConfigurations."nishant" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                modules = [
                    ./home-manager/nishant/c_cpp.nix
                    ./home-manager/nishant/dconf.nix
                    ./home-manager/nishant/env.nix
                    ./home-manager/nishant/gtk.nix
                    ./home-manager/nishant/home.nix
                    ./home-manager/nishant/lua.nix
                    ./home-manager/nishant/packages.nix
                    ./home-manager/nishant/picom.nix
                    ./home-manager/nishant/python.nix
                    ./home-manager/nishant/rust.nix
                    ./home-manager/nishant/udiskie.nix
                    ./home-manager/nishant/zsh.nix
                ];
            };

            homeConfigurations."guest" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                modules = [
                    ./home-manager/guest/c_cpp.nix
                    ./home-manager/guest/dconf.nix
                    ./home-manager/guest/env.nix
                    ./home-manager/guest/gtk.nix
                    ./home-manager/guest/home.nix
                    ./home-manager/guest/lua.nix
                    ./home-manager/guest/packages.nix
                    ./home-manager/guest/picom.nix
                    ./home-manager/guest/python.nix
                    ./home-manager/guest/rust.nix
                    ./home-manager/guest/udiskie.nix
                    ./home-manager/guest/zsh.nix
                ];
            };
        };
}
