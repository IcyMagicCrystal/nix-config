{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us";

        layout = {
	  gaps = 5;
          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
	    {proportion = 1.0;}
          ];
          preset-window-heights = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
	    {proportion = 1.0;}
          ];
          
	};

        binds = {
          "Mod+Return".spawn = lib.getExe pkgs.foot;

          "Mod+Q".close-window = _: {};
          "Mod+G".maximize-column = _: {};
          "Mod+F".fullscreen-window = _: {};
          "Mod+Shift+F".toggle-window-floating = _: {};
          "Mod+C".center-column = _: {};

          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call settings toggle";
          "Mod+Z".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call controlCenter toggle";
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+J".focus-window-down = _: {};

          "Mod+1".focus-workspace = "1";
          "Mod+2".focus-workspace = "2";
          "Mod+3".focus-workspace = "3";
          "Mod+4".focus-workspace = "4";
          "Mod+5".focus-workspace = "5";
          "Mod+6".focus-workspace = "6";
          "Mod+7".focus-workspace = "7";
          "Mod+8".focus-workspace = "8";
          "Mod+9".focus-workspace = "9";
          "Mod+0".focus-workspace = "10";

          "Mod+Shift+1".move-column-to-workspace = "1";
          "Mod+Shift+2".move-column-to-workspace = "2";
          "Mod+Shift+3".move-column-to-workspace = "3";
          "Mod+Shift+4".move-column-to-workspace = "4";
          "Mod+Shift+5".move-column-to-workspace = "5";
          "Mod+Shift+6".move-column-to-workspace = "6";
          "Mod+Shift+7".move-column-to-workspace = "7";
          "Mod+Shift+8".move-column-to-workspace = "8";
          "Mod+Shift+9".move-column-to-workspace = "9";
          "Mod+Shift+0".move-column-to-workspace = "10";

          "Mod+R".switch-preset-column-width = _:{};
          "Mod+Shift+R".switch-preset-window-height = _:{};
        };
      };
    };
  };
}
