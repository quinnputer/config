{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";

      packages = [
        pkgs.git
        pkgs.lix
      ];

      meta = {
        description = "The development environment for this configuration.";
        platforms = lib.platforms.all;
      };
    };
  };
}
