{
    description = "Home Manager configuration of nishant";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        { nixpkgs, home-manager, ... }:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in
            {
            homeConfigurations."nishant" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                modules = [
                    ./nishant/c_cpp.nix
                    ./nishant/dconf.nix
                    ./nishant/environment.nix
                    ./nishant/gtk.nix
                    ./nishant/home.nix
                    ./nishant/lua.nix
                    ./nishant/packages.nix
                    ./nishant/picom.nix
                    ./nishant/python.nix
                    ./nishant/rust.nix
                    ./nishant/zsh.nix
                ];
            };
        };
}
