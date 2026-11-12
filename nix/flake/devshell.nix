{ lib, ... }:
let
  script = ''
    cog install-hook --all --overwrite
  '';
in
{
  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) isLinux;

      qmlLibs = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
    in
    {
      devShells.default = pkgs.mkShell (finalAttrs: {
        name = "config-shell";
        shellHook = script;

        QML_IMPORT_PATH = if isLinux then qmlLibs else null;
        QMLLS_BUILD_DIRS = finalAttrs.QML_IMPORT_PATH;

        packages = lib.flatten [
          pkgs.agenix
          pkgs.caligula
          pkgs.cocogitto
          pkgs.git
          pkgs.just
          pkgs.lix
          pkgs.nh
          pkgs.nixos-anywhere

          (lib.optionals isLinux [
            pkgs.quickshell
            pkgs.qt6.qtdeclarative
            pkgs.qt6.qtbase
          ])
        ];

        meta = {
          description = "The development environment for this configuration.";
          platforms = lib.platforms.all;
        };
      });
    };
}
