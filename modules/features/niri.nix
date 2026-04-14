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
      v2-settings = true;


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
          "Mod+Shift+Slash".show-hotkey-overlay = _: {};

          "Mod+T" = _: {
            props = { hotkey-overlay-title = "Launch Terminal: Ghostty"; };
            content = {
              spawn-sh = lib.getExe pkgs.ghostty;
            };
          };
          "Mod+Shift+T" = _: {
            props = { hotkey-overlay-title = "Launch Terminal: Foot"; };
            content = {
              spawn-sh = lib.getExe pkgs.foot;
            };
          };
          "Mod+D" = _: {
            props = { hotkey-overlay-title = "Launch Launcher: Noctalia's"; };
            content = {
              spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            };
          };
          "Mod+Shift+D" = _: {
            props = { hotkey-overlay-title = "Launch Control Center: Noctalia's"; };
            content = {
              spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call controlCenter toggle";
            };
          };
          "Super+Alt+L" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
            };
          };

          "XF86AudioRaiseVolume" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
            };
          };
          "XF86AudioLowerVolume" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            };
          };
          "XF86AudioMute" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
          };
          "XF86AudioMicMute" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            };
          };

          "XF86MonBrightnessUp" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${lib.getExe pkgs.brightnessctl} --class=backlight set +10%";
            };
          };
          "XF86MonBrightnessDown" = _: {
            props = { allow-when-locked = true; };
            content = {
              spawn-sh = "${lib.getExe pkgs.brightnessctl} --class=backlight set +10-";
            };
          };
 
          "Mod+O" = _: {
            props = { repeat = false; };
            content = {
              toggle-overview = _: {};
            };
          };
          "Mod+Q" = _: {
            props = { repeat = false; };
            content = {
              close-window = _: {};
            };
          };         


          "Mod+G".maximize-column = _: {};
          "Mod+F".fullscreen-window = _: {};
          "Mod+Shift+F".toggle-window-floating = _: {};
          "Mod+C".center-column = _: {};


          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+J".focus-window-down = _: {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 10;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;
          "Mod+Shift+0".move-column-to-workspace = 10;

          "Mod+R".switch-preset-column-width = _:{};
          "Mod+Shift+R".switch-preset-window-height = _:{};
        };
      };


    };
  };
}
