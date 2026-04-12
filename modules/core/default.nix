{ self, inputs, ... }: {

  flake.nixosModules.core = { pkgs, lib, ...}: {

    imports = [
      self.nixosModules.networking
      self.nixosModules.system
    ];

  };

}
