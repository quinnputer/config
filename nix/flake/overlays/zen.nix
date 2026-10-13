{ withSystem, ... }:
{
  flake.overlays.zen =
    final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      { inputs', ... }: { zen-browser = inputs'.zen-browser.packages.default; }
    );
}
