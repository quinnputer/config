{ self, ... }:
{
  flake = {
    darwinModules.default = "${self}/nix/modules";
    nixosModules.default = "${self}/nix/modules";
  };
}
