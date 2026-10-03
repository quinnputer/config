{ self, lib, ... }:
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
        description = "The development environment for this configuration";
        maintainers = [ self.lib.maintainers.quinnputer ];
        platforms = lib.platforms.all;
      };
    };
  };
}
