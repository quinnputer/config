{ self, inputs, ... }:
let
  config = {
    allowAliases = false;
    allowUnfree = true;
  };

  overlays = [
    self.overlays.spicetify

    inputs.agenix.overlays.default
    inputs.extersia-pkgs.overlays.default
    inputs.firefox-addons.overlays.default
    inputs.glide.overlays.default
    inputs.lix-module.overlays.default
  ];
in
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs { inherit system config overlays; };
  };
}
