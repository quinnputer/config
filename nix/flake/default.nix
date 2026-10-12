{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args

    ./devshell.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
