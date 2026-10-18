let
  mkKeys = attrs: attrs // { all = builtins.attrValues attrs; };

  crona = mkKeys {
    quinn = builtins.readFile ./crona/keys/quinn.pub;
    root = builtins.readFile ./crona/keys/root.pub;
  };

  tsubaki = mkKeys {
    quinn = builtins.readFile ./tsubaki/keys/quinn.pub;
    root = builtins.readFile ./tsubaki/keys/root.pub;
  };
in
{
  inherit crona;
  inherit tsubaki;

  all = crona.all ++ tsubaki.all;
}
