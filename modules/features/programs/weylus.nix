{ self, inputs, ... }: {

  flake.nixosModules.weylus = { pkgs, lib, ...}: {

    programs.weylus = {
	enable = true;
	openFirewall = true;
	users = [ "icy" ];
    };

  };

}
