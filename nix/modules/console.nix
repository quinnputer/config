{ mkNixosAndIsoModule, ... }:
mkNixosAndIsoModule {
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };
}
