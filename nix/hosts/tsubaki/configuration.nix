{
  config,
  keys,
  pkgs,
  self,
  ...
}:
{
  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  age.secrets = {
    "passwords/quinn".file = "${self}/nix/secrets/tsubaki/passwords/quinn.age";
    "passwords/root".file = "${self}/nix/secrets/tsubaki/passwords/root.age";
  };

  users = {
    defaultUserShell = pkgs.bashInteractive;
    mutableUsers = false;
  };

  users.users.quinn = {
    isNormalUser = true;
    createHome = true;
    description = "Quinn Heyman";
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = keys.all;
    hashedPasswordFile = config.age.secrets."passwords/quinn".path;
    extraGroups = [ "wheel" ];
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets."passwords/root".path;
    openssh.authorizedKeys.keys = keys.all;
  };

  home-manager = {
    users.quinn = { };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
