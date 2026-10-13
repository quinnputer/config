{
  config,
  inputs',
  inputs,
  lib,
  pkgs,
  self',
  self,
  ...
}:
{
  system = {
    stateVersion = config.system.nixos.release;
    configurationRevision = self.rev or self.dirtRev or null;
    disableInstallerTools = true;
  };

  system.tools = {
    nixos-version.enable = true;
    nixos-rebuild.enable = true;
  };

  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  time = {
    timeZone = "Europe/Brussels";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    useNetworkd = true;
    networkmanager.enable = true;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;
  };

  nix.settings = {
    keep-going = true;
    keep-outputs = true;
    keep-derivations = true;

    warn-dirty = false;
    use-xdg-base-directories = true;

    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];

    experimental-features = [
      "flakes"
      "lix-custom-sub-commands"
      "nix-command"
      "pipe-operator"
    ];
  };

  security = {
    rtkit.enable = true;
    sudo.enable = false;
  };

  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
  };

  programs = {
    gamemode.enable = true;
    git.enable = true;
    niri.enable = true;
    pmount.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.obs-studio = {
    enable = true;

    plugins = [
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.obs-studio-plugins.obs-vaapi
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  services.pipewire = {
    enable = true;
    jack.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    extraConfig.pipewire."10-quantum"."context.properties" = {
      "default.clock.min-quantum" = 1024;
    };

    extraConfig.pipewire."99-rnnoise"."context.modules" = lib.singleton {
      name = "libpipewire-module-filter-chain";

      args = {
        "node.description" = "Noise cancelling source";
        "media.name" = "Noise cancelling source";

        "filter.graph".nodes = lib.singleton {
          type = "ladspa";
          name = "rnnoise";
          label = "noise_suppressor_mono";
          plugin = "librnnoise_ladspa";

          control = {
            "VAD Threshold (%)" = 95;
            "VAD Grace Period (ms)" = 200;
            "Retroactive VAD Grace (ms)" = 0;
          };
        };

        "capture.props" = {
          "node.name" = "capture.rnnoise_source";
          "audio.rate" = 48000;
        };

        "playback.props" = {
          "node.name" = "rnnoise_source";
          "media.class" = "Audio/Source";
          "audio.rate" = 48000;
        };
      };
    };

    extraLadspaPackages = [
      pkgs.rnnoise-plugin
    ];
  };

  users.users.quinn = {
    isNormalUser = true;
    createHome = true;
    description = "Quinn Heyman";
    shell = pkgs.bashInteractive;

    extraGroups = [
      "audio"
      "gamemode"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    users.quinn = ./home.nix;

    extraSpecialArgs = {
      inherit inputs self;
      inherit inputs' self';
    };

    sharedModules = [
      inputs.catppuccin.homeModules.default
      inputs.extersia-pkgs.homeModules.default
      inputs.nixvim.homeModules.default
      inputs.zen-browser.homeModules.default
    ];
  };

  environment = {
    defaultPackages = [ ];
  };

  environment.shells = [
    pkgs.nushell
  ];

  environment.systemPackages = [
    pkgs.crosspatch
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.lix-diff
    pkgs.mkvtoolnix
    pkgs.proton-vpn
    pkgs.qbittorrent
    pkgs.qpwgraph
    pkgs.signal-desktop
    pkgs.syncplay
    pkgs.unrar
    pkgs.unzip
    pkgs.wiremix
    pkgs.wl-clipboard
    pkgs.xwayland-satellite
  ];

  fonts = {
    enableDefaultPackages = false;
  };

  fonts.fontconfig = {
    enable = true;

    defaultFonts.monospace = [
      "Maple Mono NF"
    ];

    defaultFonts.emoji = [
      "Noto Color Emoji"
    ];

    defaultFonts.serif = [
      "Noto Serif"
      "Noto Cjk Serif"
    ];

    defaultFonts.sansSerif = [
      "Work Sans"
      "Noto Cjk Sans"
    ];

    localConf = ''
      <alias>
        <family>system-ui</family>
        <prefer><family>sans-serif</family></prefer>
      </alias>
    '';
  };

  fonts.packages = [
    pkgs.maple-mono.NF
    pkgs.montserrat
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "blue";

    sources.palette = inputs.catppuccin-palette;
    plymouth.enable = true;
  };
}
