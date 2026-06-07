{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice-gtk
    looking-glass-client
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="cheese", GROUP="kvm", MODE="0660"
  '';

  users.users.cheese.extraGroups = [ "libvirtd" "kvm" "input" ];
}
