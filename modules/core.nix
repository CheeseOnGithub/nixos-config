{ pkgs, ... }:

{
  networking = {
    hostName = "cheesemate";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  services.envfs.enable = true;
  services.openssh.enable = true;

  users.users.cheese = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
      http-connections = 1;
      stalled-download-timeout = 300;
      connect-timeout = 30;
      download-attempts = 3;
      log-lines = 50;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
