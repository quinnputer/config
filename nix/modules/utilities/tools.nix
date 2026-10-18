{ mkSystemModule, class, ... }:
let
  nixos = {
    system = {
      disableInstallerTools = true;
    };

    system.tools = {
      nixos-version.enable = true;
      nixos-enter.enable = class == "iso";
      nixos-generate-config.enable = class == "iso";
      nixos-install.enable = class == "iso";
    };

    system.tools.nixos-rebuild = {
      enable = true;
      enableRun0Elevation = true;
    };
  };

  darwin = {
    system.tools = {
      darwin-option.enable = false;
      darwin-rebuild.enable = true;
      darwin-uninstaller.enable = true;
      darwin-version.enable = true;
    };
  };
in
mkSystemModule {
  inherit nixos darwin;
  iso = nixos;
}
