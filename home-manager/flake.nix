{
  description = "Home Manager configuration of nishant";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
          ./nishant/nishant-home.nix
          ./nishant/nishant-packages.nix
          ./nishant/nishant-dconf.nix
          ./nishant/nishant-picom.nix
          ./nishant/nishant-gtk.nix
          ./nishant/nishant-zsh.nix
        ];
      };
    };
}
