{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = true;

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        identitiesOnly = true;
        addKeysToAgent = "yes";
      };
    };

    extraConfig = ''
      ServerAliveInterval 60
      ServerAliveCountMax 3
    '';
  };

  services.ssh-agent.enable = true;

  home.packages = with pkgs; [
    openssh
  ];
}
