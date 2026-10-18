{
  config,
  inputs,
  keys,
  pkgs,
  self,
  ...
}:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  age.secrets = {
    "passwords/quinn".file = "${self}/nix/secrets/tsubaki/passwords/quinn.age";
    "passwords/root".file = "${self}/nix/secrets/tsubaki/passwords/root.age";
  };

  users = {
    defaultUserShell = pkgs.bashInteractive;
    mutableUsers = false;
  };

  users.users.quinn = {
    isNormalUser = true;
    createHome = true;
    description = "Quinn Heyman";
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = keys.all;
    hashedPasswordFile = config.age.secrets."passwords/quinn".path;
    extraGroups = [ "wheel" ];
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets."passwords/root".path;
    openssh.authorizedKeys.keys = keys.all;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";

    sharedModules = [
      inputs.agenix.homeManagerModules.default
      inputs.catppuccin.homeModules.default
      inputs.extersia-pkgs.homeModules.default
      inputs.nixvim.homeModules.default
      inputs.spicetify.homeManagerModules.default
      inputs.zen-browser.homeModules.default
    ];
  };
}
