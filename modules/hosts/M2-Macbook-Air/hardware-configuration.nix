{ self, inputs, ...}: {

 flake.nixosModules.M2MacbookAirHardware = { config, lib, pkgs, modulesPath, ... }:

  {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "uas" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/80b91f31-a3ba-4495-b95c-f67cb8e45e24";
        fsType = "ext4";
      };
    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/03AF-18EC";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
