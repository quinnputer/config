{ mkNixosAndIsoModule, class, ... }:
mkNixosAndIsoModule {
  programs.nh = {
    enable = true;
    clean.enable = class != "iso";
  };

  environment.variables = {
    NH_ELEVATION_STRATEGY = "run0";
  };
}
