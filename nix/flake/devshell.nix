{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";

      packages = lib.flatten [
        pkgs.agenix
        pkgs.caligula
        pkgs.cocogitto
        pkgs.git
        pkgs.just
        pkgs.lix
        pkgs.nh
        pkgs.nixos-anywhere
        (lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.quickshell)
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
