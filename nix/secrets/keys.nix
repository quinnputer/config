let
  mkKeys = attrs: attrs // { all = builtins.attrValues attrs; };

  crona = mkKeys {
    quinn = builtins.readFile ./crona/keys/quinn.pub;
    root = builtins.readFile ./crona/keys/root.pub;
  };
in
{
  inherit crona;

  all = crona.all;
}
