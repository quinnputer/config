{
  config,
  keys,
  lib,
  pkgs,
  self,
  ...
}:
{
  soul.boot = {
    loader = "grub";
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  age.secrets = {
    "passwords/quinn".file = "${self}/nix/secrets/blackstar/passwords/quinn.age";
    "passwords/root".file = "${self}/nix/secrets/blackstar/passwords/root.age";
    "tranquil-pds/env".file = "${self}/nix/secrets/blackstar/tranquil-pds/env";
    "wireguard/private-key".file = "${self}/nix/secrets/blackstar/wireguard/private-key.age";
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

  security.acme = {
    acceptTerms = true;
    defaults.email = "quinn@emo.gay";
  };

  services.website = {
    enable = true;
    port = 6767;
  };

  services.tranquil-pds = {
    enable = true;
    database.createLocally = true;

    settings.server = {
      contact_email = "quinn@emo.gay";
      hostname = "pds.emo.gay";
      port = 2121;
    };

    settings.email = {
      from_address = "tranquil@emo.gay";
      from_name = "Tranquil PDS";
    };

    environmentFiles = [
      config.age.secrets."tranquil-pds/env".path
    ];
  };

  services.caddy = {
    enable = true;

    virtualHosts."emo.gay".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.website.port}
    '';

    virtualHosts."pds.emo.gay".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.tranquil-pds.settings.server.port}
    '';

    virtualHosts."jellyfin.emo.gay".extraConfig = ''
      reverse_proxy http://10.0.0.2:8096 {
        header_down X-Real-IP {http.request.remote}
        header_down X-Forwarded-For {http.request.remote}
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  networking.firewall.allowedUDPPorts = [
    config.networking.wg-quick.interfaces.wg0.listenPort
  ];

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets."wireguard/private-key".path;

    peers = lib.singleton {
      publicKey = builtins.readFile "${self}/nix/secrets/tsubaki/wireguard/public-key";
      allowedIPs = [ "10.0.0.2/32" ];
    };
  };
}
