{ soul-lib, ... }:
{
  flake.lib.modules.mkHelpers = class: rec {
    inherit class soul-lib;

    mkDarwinModule = module: mkSystemModule { darwin = module; };
    mkIsoModule = module: mkSystemModule { iso = module; };
    mkNixosModule = module: mkSystemModule { nixos = module; };

    mkNixosAndIsoModule =
      module:
      mkSystemModule {
        nixos = module;
        iso = module;
      };

    mkSystemModule = values: {
      imports = [
        (values.shared or { })
        (values.${class} or { })
      ];
    };
  };
}
