{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args
    ./checks
    ./options

    ./devshell.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
