let
  keys = import ./keys.nix;
in
{
  "blackstar/passwords/quinn.age".publicKeys = keys.blackstar.all;
  "blackstar/passwords/root.age".publicKeys = keys.blackstar.all;
  "blackstar/wireguard/private-key.age".publicKeys = keys.blackstar.all;

  "crona/passwords/quinn.age".publicKeys = keys.crona.all;
  "crona/passwords/root.age".publicKeys = keys.crona.all;

  "tsubaki/passwords/quinn.age".publicKeys = keys.tsubaki.all;
  "tsubaki/passwords/root.age".publicKeys = keys.tsubaki.all;
  "tsubaki/wireguard/private-key.age".publicKeys = keys.tsubaki.all;
}
