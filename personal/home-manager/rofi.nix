{
  config,
  pkgs,
  inputs,
  personalDotfilesPath,
  ...
}:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{

  home.packages = with pkgs; [
    rofi-power-menu
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun";
      font = "Dejavu Sans 12";
      show-icons = true;
      disable-history = true;
      hover-select = true;
      bw = 0;
      display-drun = "";
      display-window = "";
      display-combi = "";
      terminal = "kitty";
      drun-match-fields = "name";
      drun-display-format = "{name}";
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      kb-cancel = "Escape,MouseMiddle";
    };

    theme = {
      window = {
        transparency = "real";
        location = "center";
        anchor = "center";
        fullscreen = false;
        width = 500;
        x-offset = 0;
        y-offset = 0;
        enabled = true;
        margin = 0;
        padding = 0;
        border = mkLiteral "0px solid";
        border-radius = 8;
        cursor = mkLiteral "default";
      };

      mainbox = {
        enabled = true;
        spacing = 10;
        margin = 0;
        padding = 30;
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
      };

      inputbar = {
        enabled = true;
        spacing = 10;
        margin = 0;
        padding = 0;
        border = mkLiteral "0px solid";
        border-radius = 0;
        background-color = "transparent";
        children = [
          "textbox-prompt-colon"
          "entry"
        ];
      };

      prompt = {
        enabled = true;
      };

      "textbox-prompt-colon" = {
        enabled = true;
        expand = false;
        str = " ";
        font = "JetBrainsMono Nerd Font 12";
      };

      entry = {
        enabled = true;
        cursor = "text";
        placeholder = "Search...";
      };

      "case-indicator" = {
        enabled = true;
      };

      listview = {
        enabled = true;
        columns = 1;
        lines = 10;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = 5;
        margin = 0;
        padding = 0;
        border = mkLiteral "0px solid";
        border-radius = 0;
        cursor = "default";
      };

      scrollbar = {
        handle-width = 5;
        border-radius = 8;
      };

      element = {
        enabled = true;
        spacing = 8;
        margin = 0;
        padding = 8;
        border = mkLiteral "0px solid";
        border-radius = 4;
        cursor = "pointer";
      };

      "element-icon" = {
        size = 24;
        cursor = "inherit";
      };

      "element-text" = {
        highlight = "inherit";
        cursor = "inherit";
        vertical-align = 1;
        horizontal-align = 0;
      };

      button = {
        padding = 8;
        border = mkLiteral "0px solid";
        border-radius = 4;
        cursor = "pointer";
      };

      message = {
        enabled = true;
        margin = 0;
        padding = 0;
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
      };

      textbox = {
        padding = 8;
        border = mkLiteral "0px solid";
        border-radius = 4;
        vertical-align = 1;
        horizontal-align = 0;
        highlight = "none";
        blink = true;
        markup = true;
      };

      "error-message" = {
        padding = 10;
        border = mkLiteral "0px solid";
        border-radius = 4;
      };
    };
  };
}
