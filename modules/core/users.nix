{ self, inputs, ... }: {

  flake.nixosModules.users = { pkgs, lib, config, ... }: {

    imports = [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.icy = self.homeModules.usersIcy;

        # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
      }
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.icy = {
      isNormalUser = true;
      description = "icy";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

}
