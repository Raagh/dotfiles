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
      "*" = {
        width = 512;
      };
      #
      # "#inputbar" = {
      #   children = map mkLiteral [
      #     "prompt"
      #     "entry"
      #   ];
      # };
      #
      # "#textbox-prompt-colon" = {
      #   expand = false;
      #   str = ":";
      #   margin = mkLiteral "0px 0.3em 0em 0em";
      #   text-color = mkLiteral "@foreground-color";
      # };
    };
  };
}
