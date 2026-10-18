{ mkNixosAndIsoModule, ... }:
mkNixosAndIsoModule {
  networking.useNetworkd = true;
}
