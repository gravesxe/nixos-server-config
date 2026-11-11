{ pkgs, ... }:

{
  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    packages = with pkgs; [
      btop
      tree
    ];
    stateVersion = "26.05";
  };

  programs = {
    micro = {
      enable = true;
      settings = {
        autosu = true;
        colorscheme = "simple";
        diffgutter = true;
        fmtcmd = "nixfmt";
        fmtonsave = true;
        rmtrailingws = true;
        saveundo = true;
        tabsize = 2;
        tabstospaces = true;
      };
    };

    fish = {
      enable = true;
      shellAliases = {
        rebuild = "nh os switch";
        cleanup = "nh clean all";
      };
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "admin";
          email = "admin@localhost";
        };
      };
    };
  };

  xdg = {
    configFile = {
      "micro/plugins/autofmt.lua" = {
        text = ''
          local config = import("micro/config")
          local buffer = import("micro/buffer")
          local util = import("micro/util")

          function onSave(bp)
              if bp.Buf.Settings["filetype"] == "nix" then
                  bp:Save()
                  local out, err = util.RunTool("nixfmt " .. bp.Buf.Path)
                  if err == nil then
                      bp.Buf:ReOpen()
                  end
              end
          end
        '';
      };
    };
  };
}