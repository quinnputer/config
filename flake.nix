{
  description = "My Linux and MacOS system configurations.";
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./nix/flake;

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems = {
      url = "github:nix-systems/default";
    };
  };
}
