{ withSystem, ... }:
{
  flake.overlays.spicetify =
    final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      { inputs', ... }: { spicePackages = inputs'.spicetify.legacyPackages; }
    );
}
