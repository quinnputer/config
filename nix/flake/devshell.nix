{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";

      packages = [
        pkgs.cocogitto
        pkgs.git
        pkgs.lix
      ];

      shellHook = ''
        cog install-hook --all --overwrite
      '';

      meta = {
        description = "The development environment for this configuration.";
        platforms = lib.platforms.all;
      };
    };
  };
}
