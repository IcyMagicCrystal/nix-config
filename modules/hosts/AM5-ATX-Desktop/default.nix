{ self, inputs, ... }: {

  flake.nixosConfigurations.AM5-ATX-Desktop = inputs.nixpkgs.lib.nixosSystem {

    modules = [
      self.nixosModules.AM5ATXDesktopConfiguration
    ];

  };

}
