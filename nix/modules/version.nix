{ config, ... }:
{
  system.stateVersion = config.lib.soul.systems.switch {
    linux = config.system.nixos.release;
    darwin = config.system.maxStateVersion;
  };
}
