{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args
    ./checks
    ./options

    ./devshell.nix
    ./hosts.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
