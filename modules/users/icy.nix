{ self, inputs, ... }: {

  flake.nixosModules.usersIcy = { pkgs, lib, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.icy = {
      isNormalUser = true;
      description = "icy";
      extraGroups = [ "networkmanager" "wheel" ];

      
      packages = with pkgs; [
        orca-slicer
        freecad
        joplin-desktop
        kicad
      ];
    };
  };

}
