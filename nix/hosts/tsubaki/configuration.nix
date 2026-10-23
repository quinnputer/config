{
  config,
  keys,
  lib,
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
    "wireguard/private-key".file = "${self}/nix/secrets/tsubaki/wireguard/private-key.age";
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

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.2/24" ];
    privateKeyFile = config.age.secrets."wireguard/private-key".path;

    peers = lib.singleton {
      publicKey = builtins.readFile "${self}/nix/secrets/blackstar/wireguard/public-key";
      allowedIPs = [ "10.0.0.1/32" ];
      endpoint = "emo.gay:51820";
      persistentKeepalive = 25;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  networking.firewall.interfaces.wg0.allowedTCPPorts = [
    8096
  ];
}
