{ pkgs, soul-lib, ... }:
{
  lib.soul.systems = soul-lib.systems.mkHelpers pkgs;
}
