{
  pkgs,
  config,
  lib,
  ...
}:
let
  aerospace-swipe-pkg = import ./aerospace-swipe.nix { inherit pkgs; };
  hyper = "alt-shift-cmd-ctrl";
in
{

  environment.systemPackages = with pkgs; lib.optionals pkgs.stdenv.isDarwin [
    aerospace
    jankyborders
    sketchybar
    nowplaying-cli
    switchaudio-osx
    aerospace-swipe-pkg
  ];

  services.aerospace = lib.optionals pkgs.stdenv.isDarwin {
    enable = true;
    settings = {
      after-login-command = [ ];
      after-startup-command = [ ];
      exec-on-workspace-change = [
        "/bin/zsh"
        "-c"
        "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE FOCUSED_DISPLAY=$(aerospace list-monitors --focused | awk \"{print $1}\")"
      ];
      on-focus-changed = [
        "move-mouse window-lazy-center"
        "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_focus_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];
      on-focused-monitor-changed = [
        "move-mouse monitor-lazy-center"
      ];

      start-at-login = false;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      automatically-unhide-macos-hidden-apps = false;

      accordion-padding = 30;
      gaps = {
        inner = {
          horizontal = 8;
          vertical =   8;
        };
        outer = {
          left =       8;
          bottom =     8;
          top =        [
            { monitor."Built-in.*" = 8; }
            40
          ];
          right =      8;
        };
      };

      key-mapping.preset = "qwerty";

      mode.main.binding = {
        alt-shift-cmd-ctrl-j = ["mode join" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_enter_service_mode"];
        alt-shift-cmd-ctrl-m = ["mode move" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_enter_move_mode"];
        alt-shift-cmd-ctrl-semicolon = ["mode service" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_enter_service_mode"];

        alt-shift-cmd-ctrl-minus = "resize smart -50";
        alt-shift-cmd-ctrl-equal = "resize smart +50";

        alt-shift-cmd-ctrl-slash = "layout tiles horizontal vertical";
        alt-shift-cmd-ctrl-comma = "layout accordion horizontal vertical";

        alt-shift-cmd-ctrl-a = "focus left";
        alt-shift-cmd-ctrl-s = "focus down";
        alt-shift-cmd-ctrl-d = "focus up";
        alt-shift-cmd-ctrl-f = "focus right";

        alt-shift-cmd-ctrl-b = "workspace B";
        alt-shift-cmd-ctrl-e = "workspace E";
        alt-shift-cmd-ctrl-t = "workspace T";

        alt-shift-cmd-ctrl-1 = "workspace 1";
        alt-shift-cmd-ctrl-2 = "workspace 2";
        alt-shift-cmd-ctrl-3 = "workspace 3";
        alt-shift-cmd-ctrl-4 = "workspace 4";
        alt-shift-cmd-ctrl-5 = "workspace 5";
        alt-shift-cmd-ctrl-6 = "workspace 6";

        alt-shift-cmd-ctrl-l = "layout floating tiling";
        alt-shift-cmd-ctrl-o = "fullscreen";
        alt-shift-cmd-ctrl-tab = "workspace-back-and-forth";
      };

      mode.move.binding = {
        esc = ["mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        a = "move left";
        s = "move down";
        d = "move up";
        f = "move right";

        "${hyper}-a" = "focus left";
        "${hyper}-s" = "focus down";
        "${hyper}-d" = "focus up";
        "${hyper}-f" = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
        tab = ["move-workspace-to-monitor --wrap-around next" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];

        b = ["move-node-to-workspace B" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        e = ["move-node-to-workspace E" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        t = ["move-node-to-workspace T" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];

        "1" = ["move-node-to-workspace 1" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        "2" = ["move-node-to-workspace 2" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        "3" = ["move-node-to-workspace 3" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        "4" = ["move-node-to-workspace 4" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        "5" = ["move-node-to-workspace 5" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        "6" = ["move-node-to-workspace 6" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
      };

      mode.join.binding = {
        esc = ["mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        a = ["join-with left" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        s = ["join-with down" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        d = ["join-with up" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        f = ["join-with right" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
      };

      mode.service.binding = {
        esc = ["mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];
        r = ["flatten-workspace-tree" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"]; # reset layout

        down = "volume down";
        up = "volume up";
        shift-down = [ "volume set 0" "mode main" "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_leave_service_mode"];

        b = "workspace B";
        e = "workspace E";
        t = "workspace T";

        "1" = "workspace 1";
        "2" = "workspace 2";
        "3" = "workspace 3";
        "4" = "workspace 4";
        "5" = "workspace 5";
        "6" = "workspace 6";
      };

      on-window-detected = [
        {
          "if" = { app-id = "com.1password.1password"; };
          run = ["layout floating"];
        }
        {
          "if" = { window-title-regex-substring = "Picture-in-Picture"; };
          run = ["layout floating"];
        }
      ];
    };
  };


  services.sketchybar = lib.optionals pkgs.stdenv.isDarwin {
    enable = true;
    package = pkgs.sketchybar;
    extraPackages = [ pkgs.lua5_4_compat ];
  };

  services.jankyborders = lib.optionals pkgs.stdenv.isDarwin {
    enable = true;
    package = pkgs.jankyborders;
    active_color = "0xffff5500";
    inactive_color = "0xffe1e3e4";
    width = 4.0;
  };

  # Add launchd agent for aerospace-swipe
  launchd.agents.aerospace-swipe = {
    serviceConfig = {
      Label = "com.acsandmann.swipe"; # Match the original plist's label
      ProgramArguments = [
        "${aerospace-swipe-pkg}/bin/swipe"
      ];
      RunAtLoad = true;
      KeepAlive = true; # Keep the agent running
      # Log files for debugging, similar to the original plist
      StandardOutPath = "/tmp/aerospace-swipe.out";
      StandardErrorPath = "/tmp/aerospace-swipe.err";
      # PATH environment variable is typically handled by nix-darwin for launched services.
    };
  };
}
