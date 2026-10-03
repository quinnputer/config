{ lib, self, ... }:
let
  script = ''
    cd "${self}"
    locker
    touch "$out"
  '';

  meta = {
    description = "Check for duplicate lockfile entries";
    maintainers = [ self.lib.maintainers.quinnputer ];
    platforms = lib.platforms.all;
  };
in
{
  perSystem = { pkgs, ... }: {
    checks.locker = pkgs.runCommand "locker-check" {
      inherit meta;
      nativeBuildInputs = [ pkgs.locker ];
    } script;
  };
}
