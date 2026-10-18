let
  keys = import ./keys.nix;
in
{
  "crona/passwords/quinn.age".publicKeys = keys.crona.all;
  "crona/passwords/root.age".publicKeys = keys.crona.all;

  "tsubaki/passwords/quinn.age".publicKeys = keys.tsubaki.all;
  "tsubaki/passwords/root.age".publicKeys = keys.tsubaki.all;
}
