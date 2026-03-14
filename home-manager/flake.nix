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
          ./nishant/dconf.nix
          ./nishant/environment.nix
          ./nishant/gtk.nix
          ./nishant/home.nix
          ./nishant/packages.nix
          ./nishant/picom.nix
          ./nishant/zsh.nix
        ];
      };
    };
}
