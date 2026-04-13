{ self, inputs, ... }: {

  flake.nixosConfigurations.M2-Macbook-Air = inputs.nixpkgs.lib.nixosSystem {

    modules = [
      self.nixosModules.M2MacbookAirConfiguration
    ];

  };

}
