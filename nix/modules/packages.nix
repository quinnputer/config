{ mkSystemModule, ... }:
mkSystemModule {
  shared = {
    environment.defaultPackages = [ ];
  };

  nixos = {
    fonts.enableDefaultPackages = false;
  };
}
