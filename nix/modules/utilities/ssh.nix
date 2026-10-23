{ keys, ... }:
{
  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    "quinn@blackstar" = {
      hostNames = [ "emo.gay" ];
      publicKey = keys.blackstar.quinn;
    };

    "root@blackstar" = {
      hostNames = [ "emo.gay" ];
      publicKey = keys.blackstar.root;
    };

    "quinn@crona" = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.quinn;
    };

    "root@crona" = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.root;
    };

    "quinn@tsubaki" = {
      hostNames = [ "tsubaki.local" ];
      publicKey = keys.tsubaki.quinn;
    };

    "root@tsubaki" = {
      hostNames = [ "tsubaki.local" ];
      publicKey = keys.tsubaki.root;
    };
  };

  soul.home.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."Host blackstar" = {
      HostName = "emo.gay";
      User = "quinn";
    };

    settings."Host crona" = {
      HostName = "crona.local";
      User = "quinn";
    };

    settings."Host tsubaki" = {
      HostName = "tsubaki.local";
      User = "quinn";
    };
  };
}
