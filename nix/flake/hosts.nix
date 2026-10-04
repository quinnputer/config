{
  inputs,
  self,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.crona = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.default
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      inputs.tgirlpkgs.nixosModules.default

      { nixpkgs.pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs); }

      "${self}/nix/hosts/crona"
    ];

    specialArgs = {
      inherit inputs self;
    };
  };
}
