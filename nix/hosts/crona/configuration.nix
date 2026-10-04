{ self, config, ... }:
{
  system = {
    stateVersion = config.system.nixos.release;
    configurationRevision = self.rev or self.dirtRev or null;
    disableInstallerTools = true;
  };

  environment = {
    defaultPackages = [ ];
  };

  time = {
    timeZone = "Europe/Brussels";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    useXkbConfig = true;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      use-xdg-base-directories = true;
      warn-dirty = false;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };
  };

  programs = {
    git.enable = true;
    neovim.enable = true;
    pmount.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.tools = {
    nixos-rebuild.enable = true;
    nixos-version.enable = true;
  };

  users.users.quinn = {
    description = "Quinn Heyman";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
  };

  security.sudo = {
    enable = false;
  };

  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
    };
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };
}
