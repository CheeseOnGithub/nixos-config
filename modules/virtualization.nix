{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package      = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true; 

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice-gtk
  ];

  users.users.cheese.extraGroups = [ "libvirtd" "kvm" ];
}
