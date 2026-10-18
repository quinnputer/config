let
  keys = import ./keys.nix;
in
{
  "crona/passwords/quinn.age".publicKeys = keys.crona.all;
  "crona/passwords/root.age".publicKeys = keys.crona.all;
}
