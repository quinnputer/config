{ mkNixosModule, ... }:
mkNixosModule {
  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  environment.variables = {
    NH_ELEVATION_STRATEGY = "run0";
  };
}
