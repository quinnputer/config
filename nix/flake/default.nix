{ inputs, ... }:
{
  imports = [
    inputs.easy-hosts.flakeModule
    inputs.treefmt.flakeModule

    ./args
    ./checks
    ./overlays

    ./devshell.nix
    ./hosts.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
