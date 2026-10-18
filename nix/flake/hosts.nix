{
  inputs,
  lib,
  self,
  ...
}:
let
  modules.nixos = [
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];

  modules.iso = [
    inputs.catppuccin.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];

  modules.darwin = [
    inputs.agenix.darwinModules.default
    inputs.catppuccin.darwinModules.default
    inputs.extersia-pkgs.darwinModules.default
    inputs.home-manager.darwinModules.default
  ];
in
{
  easy-hosts = {
    useGlobalPkgs = true;

    hosts.crona = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/nix/hosts/crona";
    };

    perClass = class: {
      modules = lib.getAttr class modules;
    };
  };
}
