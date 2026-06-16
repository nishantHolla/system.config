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

            nixosConfigurations.template = nixpkgs.lib.nixosSystem { ## --START--
                modules = [
                    ./nixos/template/config.nix
                    ./nixos/template/packages.nix
                    ./nixos/template/hardware.nix
                ];
            }; ## --END--

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
                    ./home-manager/nishant/zsh.nix
                ];
            };

        };
}
