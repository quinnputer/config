{ pkgs, config, ... }:
let
  sudoers = config.lib.soul.systems.switch {
    linux = [ "@wheel" ];
    darwin = [ "@admin" ];
  };
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc.automatic = pkgs.stdenv.hostPlatform.isDarwin;
  };

  nix.settings = {
    keep-going = true;
    keep-outputs = true;
    keep-derivations = true;

    warn-dirty = false;
    use-xdg-base-directories = true;

    allowed-users = sudoers;
    trusted-users = sudoers;

    experimental-features = [
      "flakes"
      "lix-custom-sub-commands"
      "nix-command"
      "pipe-operator"
    ];
  };

  environment.systemPackages = [
    pkgs.lix-diff
  ];
}
