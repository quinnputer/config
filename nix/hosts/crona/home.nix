{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  self,
  ...
}:
let
  inherit (config.home) homeDirectory;

  palette = lib.importJSON "${inputs.catppuccin-palette}/palette.json";
  colors = (lib.getAttr config.catppuccin.flavor palette).colors;
in
{
  home = {
    preferXdgDirectories = true;
  };

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  home.shellAliases = {
    q = "exit";
    cls = "clear";
    cat = lib.getExe pkgs.bat;
    lf = lib.getExe pkgs.yazi;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${homeDirectory}/desktop";
    documents = "${homeDirectory}/documents";
    download = "${homeDirectory}/downloads";
    music = "${homeDirectory}/music";
    pictures = "${homeDirectory}/pictures";
    projects = "${homeDirectory}/projects";
    publicShare = "${homeDirectory}/public";
    templates = "${homeDirectory}/templates";
    videos = "${homeDirectory}/videos";
  };

  programs = {
    bat.enable = true;
    carapace.enable = true;
    home-manager.enable = true;
    lazygit.enable = true;
    nix-your-shell.enable = true;
    vesktop.enable = true;
    yazi.enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nushell = {
    inherit (config.home) shellAliases;

    enable = true;
    settings.show_banner = false;
  };

  programs.bash = {
    enable = true;
    initExtra = lib.mkOrder 2000 ''exec "${lib.getExe pkgs.nushell}"'';
  };

  programs.spicetify = {
    enable = true;
    theme = pkgs.spicePackages.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
  };

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${homeDirectory}/.ssh/id_ed25519.pub";
    };

    settings = {
      core.ignorecase = false;
      pull.rebase = true;
      init.defaultBranch = "main";

      user = {
        name = "Quinn Heyman";
        email = "quinn@emo.gay";
      };

      alias = {
        check = "!${lib.getExe pkgs.cocogitto} check";
        lga = "log --decorate --oneline --graph";
        put = "push --set-upstream";
        ui = "!${lib.getExe pkgs.lazygit}";
      };
    };
  };

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = 0.95;
      confirm_os_window_close = 0;

      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };
  };

  programs.mpv = {
    enable = true;

    scripts = [
      pkgs.mpvScripts.modernz
      pkgs.mpvScripts.thumbfast
    ];

    config = {
      ao = "pulse";
      osc = "no";
      target-colorspace-hint = "no";
    };

    scriptOpts.modernz = {
      icon_theme = "material";
    };
  };

  programs.prismlauncher = {
    enable = true;

    settings = {
      ApplicationTheme = "system";
      AutomaticJavaDownload = false;
      JavaPath = lib.getExe' pkgs.openjdk "java";
      Language = osConfig.i18n.defaultLocale;
      UserAskedAboutAutomaticJavaDownload = true;
    };
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    nixpkgs.source = inputs.nixpkgs;
    imports = [ ./neovim.nix ];
  };

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      name = "Default";
      isDefault = true;
      containersForce = true;
      spacesForce = true;
      pinsForce = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "extensions.autoDisableScopes" = false;
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "zen.urlbar.replace-newtab" = false;
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
      };

      search = {
        force = true;
        default = "ddg";
      };

      extensions = {
        force = true;

        packages = [
          pkgs.firefox-addons.catppuccin-web-file-icons
          pkgs.firefox-addons.proton-pass
          pkgs.firefox-addons.shinigami-eyes
          pkgs.firefox-addons.sponsorblock
          pkgs.firefox-addons.stylus
          pkgs.firefox-addons.tablissng
          pkgs.firefox-addons.ublock-origin
          pkgs.firefox-addons.yomitan
          pkgs.firefox-addons.youtube-shorts-block
        ];
      };

      bookmarks = {
        force = true;

        settings = [
          {
            name = "Toolbar";
            toolbar = true;

            bookmarks = [
              {
                name = "YouTube";
                url = "https://www.youtube.com";
              }
              {
                name = "Music";
                url = "https://music.youtube.com";
              }
              "separator"
              {
                name = "Mail";
                url = "https://mail.proton.me";
              }
              {
                name = "Calendar";
                url = "https://calendar.proton.me";
              }
              {
                name = "Drive";
                url = "https://drive.proton.me";
              }
              {
                name = "Passwords";
                url = "https://pass.proton.me";
              }
              "separator"
              {
                name = "GitHub";
                url = "https://github.com";
              }
              {
                name = "Tangled";
                url = "https://tangled.org";
              }
              "separator"
              {
                name = "Witchsky";
                url = "https://witchsky.app";
              }
              {
                name = "Aturi";
                url = "https://aturi.to";
              }
              {
                name = "Marque";
                url = "https://marque.at";
              }
              "separator"
              {
                name = "Letterboxd";
                url = "https://letterboxd.com";
              }
              {
                name = "MAL";
                url = "https://myanimelist.net";
              }
              {
                name = "AOTY";
                url = "https://www.albumoftheyear.org";
              }
              "separator"
              {
                name = "ProtonDB";
                url = "https://www.protondb.com";
              }
              "separator"
              {
                name = "Nix";

                bookmarks = [
                  {
                    name = "Nix.ee";
                    url = "https://nix.ee";
                  }
                  {
                    name = "Search";
                    url = "https://search.nix.ee";
                  }
                  {
                    name = "Docs";
                    url = "https://docs.nix.ee";
                  }
                ];
              }
              {
                name = "Dles";

                bookmarks = [
                  {
                    name = "Raddle";
                    url = "https://raddle.quest";
                  }
                  {
                    name = "Connections";
                    url = "https://www.nytimes.com/games/connections";
                  }
                  {
                    name = "Framed";
                    url = "https://framed.wtf";
                  }
                  {
                    name = "Box-office Game";
                    url = "https://boxofficega.me";
                  }
                  {
                    name = "Scrandle";
                    url = "https://scrandle.com";
                  }
                ];
              }
            ];
          }
        ];
      };

      containers.default = {
        color = "purple";
        icon = "fingerprint";
        id = 1;
      };

      spaces.default = {
        id = "13a3da61-48c4-4d49-8166-174419b311a7";
        position = 1000;
        container = config.programs.zen-browser.profiles.default.containers.default.id;

        theme.colors = lib.singleton {
          red = colors.base.rgb.r;
          green = colors.base.rgb.g;
          blue = colors.base.rgb.b;
        };
      };
    };
  };

  wayland.windowManager.niri = {
    enable = true;

    settings = {
      prefer-no-csd = { };
      screenshot-path = "${config.xdg.userDirs.pictures}/screenshots/%Y-%m-%d_%H-%M-%S.png";
    };

    settings.input = {
      warp-mouse-to-focus = { };
      focus-follows-mouse._props.max-scroll-amount = "2%";

      keyboard = {
        numlock = { };
      };

      keyboard.xkb = {
        layout = osConfig.services.xserver.xkb.layout;
        options = osConfig.services.xserver.xkb.options;
      };

      touchpad = {
        tap = { };
        natural-scroll = { };
      };
    };

    settings.overview.workspace-shadow = {
      off = { };
    };

    settings.layout = {
      gaps = 10;
      center-focused-column = "never";
      background-color = "transparent";
      default-column-width.proportion = 0.5;
      focus-ring.off = { };

      border = {
        width = 2;
        active-color = colors.blue.hex;
        inactive-color = colors.overlay0.hex;
        urgent-color = colors.red.hex;
      };

      shadow = {
        on = { };
        softness = 30;
        spread = 5;
        color = colors.base.hex;
      };

      preset-column-widths._children = [
        { proportion = 0.33333; }
        { proportion = 0.50000; }
        { proportion = 0.66666; }
      ];
    };

    settings.hotkey-overlay = {
      skip-at-startup = { };
    };

    settings.window-rule = {
      geometry-corner-radius = 6;
      clip-to-geometry = true;
    };

    settings.binds = {
      "Mod+O".toggle-overview = { };
      "Mod+S".screenshot = { };

      "Mod+Return".spawn = lib.getExe pkgs.kitty;
      "Mod+B".spawn = lib.getExe pkgs.zen-browser;

      "Mod+F".maximize-column = { };
      "Mod+Shift+F".fullscreen-window = { };

      "Mod+Q".close-window = { };
      "Mod+Shift+Q".quit = { };

      "Mod+H".focus-column-left = { };
      "Mod+L".focus-column-right = { };
      "Mod+J".focus-window-or-workspace-down = { };
      "Mod+K".focus-window-or-workspace-up = { };

      "Mod+1".focus-workspace = 1;
      "Mod+2".focus-workspace = 2;
      "Mod+3".focus-workspace = 3;
      "Mod+4".focus-workspace = 4;
      "Mod+5".focus-workspace = 5;
      "Mod+6".focus-workspace = 6;
      "Mod+7".focus-workspace = 7;
      "Mod+8".focus-workspace = 8;
      "Mod+9".focus-workspace = 9;

      "Mod+Shift+1".move-column-to-workspace = 1;
      "Mod+Shift+2".move-column-to-workspace = 2;
      "Mod+Shift+3".move-column-to-workspace = 3;
      "Mod+Shift+4".move-column-to-workspace = 4;
      "Mod+Shift+5".move-column-to-workspace = 5;
      "Mod+Shift+6".move-column-to-workspace = 6;
      "Mod+Shift+7".move-column-to-workspace = 7;
      "Mod+Shift+8".move-column-to-workspace = 8;
      "Mod+Shift+9".move-column-to-workspace = 9;
    };
  };

  xdg.dataFile."kdenlive/export/customprofiles.xml" = {
    source = "${self}/config/kdenlive/custom-export-profiles.xml";
  };

  catppuccin = {
    inherit (osConfig.catppuccin) enable autoEnable;
    inherit (osConfig.catppuccin) flavor accent;

    sources.palette = inputs.catppuccin-palette;
    mpv.enable = false;
  };
}
