{
  class,
  lib,
  mkSystemModule,
  ...
}:
let
  mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
  mkKeyValues = lib.generators.toKeyValue { inherit mkKeyValue; };

  settings = {
    PasswordAuthentication = class == "iso";
  };
in
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh = {
    inherit settings;
  };

  iso.services.openssh = {
    inherit settings;
  };

  darwin.services.openssh = {
    extraConfig = mkKeyValues settings;
  };
}
