{
  config,
  inputs',
  inputs,
  lib,
  self',
  self,
  ...
}:
let
  externalModules = [
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.default
    inputs.extersia-pkgs.homeModules.default
    inputs.glide.homeModules.default
    inputs.nixvim.homeModules.default
    inputs.spicetify.homeManagerModules.default
  ];
in
{
  options.soul.home = lib.mkOption {
    default = { };
    description = "Home manager configuration shared between all users.";
    type = lib.types.deferredModule;
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "home-manager-backup";
      sharedModules = externalModules ++ [ config.soul.home ];
    };

    home-manager.extraSpecialArgs = {
      inherit inputs self;
      inherit inputs' self';
    };

    soul.home = {
      programs.home-manager.enable = true;
    };
  };
}
