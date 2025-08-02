{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {

    nixosConfigurations.template = nixpkgs.lib.nixosSystem {
      modules = [
        ./template/config.nix
        ./template/packages.nix
        ./template/hardware.nix
      ];
    };

    nixosConfigurations.nixosVM = nixpkgs.lib.nixosSystem {
      modules = [
        ./nixosVM/config.nix
        ./nixosVM/packages.nix
        ./nixosVM/hardware.nix
      ];
    };

  };
}
