{ pkgs, soul-lib, ... }:
{
  lib.systems = soul-lib.systems.mkHelpers pkgs;
}
