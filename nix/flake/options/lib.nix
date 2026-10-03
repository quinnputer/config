{ lib, flake-parts-lib, ... }:
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    lib = lib.mkOption {
      default = { };
      description = "Extra library functions to export from this flake.";
      type = lib.types.attrsOf lib.types.unspecified;
    };
  };
}
