{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args
    ./options

    ./devshell.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
