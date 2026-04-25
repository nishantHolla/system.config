{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {

    nixosConfigurations.template = nixpkgs.lib.nixosSystem { ## --START--
      modules = [
        ./template/config.nix
        ./template/packages.nix
        ./template/hardware.nix
      ];
    }; ## --END--

  };
}
