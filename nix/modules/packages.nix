{ mkSystemModule, ... }:
let
  nixos.fonts.enableDefaultPackages = false;
in
mkSystemModule {
  inherit nixos;

  shared.environment.defaultPackages = [ ];
  iso = nixos;
}
