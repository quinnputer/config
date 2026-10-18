{ mkSystemModule, lib, ... }:
let
  mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
  mkKeyValues = lib.generators.toKeyValue { inherit mkKeyValue; };

  settings = {
    PasswordAuthentication = false;
  };
in
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh = {
    inherit settings;
  };

  darwin.services.openssh = {
    extraConfig = mkKeyValues settings;
  };
}
