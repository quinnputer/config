{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.boot.loader;
  limit = 10;

  loaders = [
    "grub"
    "systemd-boot"
  ];
in
mkNixosModule {
  options.soul.boot.loader = lib.mkOption {
    default = "systemd-boot";
    description = "The boot loader to use.";
    example = "grub";
    type = lib.types.enum loaders;
  };

  config.boot.loader = {
    efi = {
      canTouchEfiVariables = cfg == "systemd-boot";
    };

    systemd-boot = {
      enable = cfg == "systemd-boot";
      configurationLimit = limit;
    };

    grub = {
      enable = cfg == "grub";
      configurationLimit = limit;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
}
