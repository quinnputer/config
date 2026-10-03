{ self, lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";

      packages = [
        pkgs.git
        pkgs.lix
      ];

      meta = {
        description = "The development environment for this configuration";
        maintainers = [ self.lib.maintainers.quinnputer ];
        platforms = lib.platforms.all;
      };
    };
  };
}
