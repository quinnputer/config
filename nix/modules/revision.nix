{ self, ... }:
{
  system.configurationRevision = self.rev or self.dirtRev or null;
}
