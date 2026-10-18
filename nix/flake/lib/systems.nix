{ soul-lib, ... }:
{
  flake.lib.systems.mkHelpers = pkgs: {
    switch = soul-lib.systems.switch pkgs;
  };

  flake.lib.systems.switch =
    pkgs:
    { linux, darwin }:
    let
      platform = pkgs.stdenv.hostPlatform;
    in
    if platform.isLinux then
      linux
    else if platform.isDarwin then
      darwin
    else
      throw "unsupported system '${platform.system}' detected";
}
