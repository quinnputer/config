{
  config,
  lib,
  pkgs,
  ...
}:
let
  nameParts = [
    config.networking.hostName
    pkgs.stdenv.hostPlatform.uname.processor
  ];
in
{
  image = {
    baseName = lib.mkImageMediaOverride (lib.concatStringsSep "-" nameParts);
  };

  isoImage = {
    volumeID = config.image.baseName;
    appendToMenuLabel = "";
    edition = "";
  };

  users.users.nixos = {
    enable = false;
  };

  users.users.soul = {
    isNormalUser = true;
    description = "Soul";
    initialHashedPassword = "$y$j9T$L32Kyj240pZK9Zip/3ki61$umfh6ZtITMpK4ASS7AVrsTGAIz1ekOjVCZsXM8bPbe.";
    shell = pkgs.bashInteractive;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  services.getty = {
    autologinUser = lib.mkForce "soul";
  };
}
