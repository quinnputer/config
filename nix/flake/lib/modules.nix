{ soul-lib, ... }:
{
  flake.lib.modules.mkHelpers = class: rec {
    inherit class soul-lib;

    mkDarwinModule = module: mkSystemModule { darwin = module; };
    mkIsoModule = module: mkSystemModule { iso = module; };
    mkNixosModule = module: mkSystemModule { nixos = module; };

    mkSystemModule = values: {
      imports = [
        (values.shared)
        (values.${class} or { })
      ];
    };
  };
}
