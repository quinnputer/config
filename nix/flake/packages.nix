{ self, ... }:
{
  flake.packages.x86_64-linux = {
    soul-iso = self.nixosConfigurations.soul.config.system.build.isoImage;
  };
}
