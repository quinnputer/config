let
  mkKeys = attrs: attrs // { all = builtins.attrValues attrs; };

  blackstar = mkKeys {
    quinn = builtins.readFile ./blackstar/keys/quinn.pub;
    root = builtins.readFile ./blackstar/keys/root.pub;
  };

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
  inherit blackstar;
  inherit crona;
  inherit tsubaki;

  all = blackstar.all ++ crona.all ++ tsubaki.all;
}
