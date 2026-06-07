{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [ "amd_iommu=on" "iommu=pt" ];

    initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
    kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "kvmfr" ];

    extraModulePackages = [ pkgs.linuxPackages_zen.kvmfr ];

    extraModprobeConfig = ''
      options vfio-pci ids=1002:13c0,1002:1640
      options kvmfr static_size_mb=128
    '';
  };
}
