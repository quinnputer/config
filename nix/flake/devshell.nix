{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";

      packages = [
        pkgs.agenix
        pkgs.caligula
        pkgs.cocogitto
        pkgs.git
        pkgs.just
        pkgs.lix
        pkgs.nh
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
