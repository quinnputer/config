{ mkNixosAndIsoModule, ... }:
mkNixosAndIsoModule {
  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
  };
}
