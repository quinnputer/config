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

  services.nginx = {
    enable = true;

    virtualHosts."jellyfin.emo.gay" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://10.0.0.2:8096";
        proxyWebsockets = true;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };

    virtualHosts."emo.gay" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://localhost:${toString config.services.website.port}";
    };
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
