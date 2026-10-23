{
  inputs,
  keys,
  lib,
  self,
  soul-lib,
  ...
}:
let
  modules.nixos = [
    self.nixosModules.default
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];

  modules.iso = [
    self.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
  ];

  modules.darwin = [
    self.darwinModules.default
    inputs.agenix.darwinModules.default
    inputs.catppuccin.darwinModules.default
    inputs.extersia-pkgs.darwinModules.default
    inputs.home-manager.darwinModules.default
  ];
in
{
  easy-hosts = {
    useGlobalPkgs = true;

    hosts.blackstar = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/nix/hosts/blackstar";
    };

    hosts.crona = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/nix/hosts/crona";
    };

    # hosts.soul = {
    #   arch = "x86_64";
    #   class = "iso";
    #   path = "${self}/nix/hosts/soul";
    # };

    hosts.tsubaki = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/nix/hosts/tsubaki";
    };

    shared = {
      specialArgs = { inherit keys; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
      specialArgs = soul-lib.modules.mkHelpers class;
    };
  };
}
