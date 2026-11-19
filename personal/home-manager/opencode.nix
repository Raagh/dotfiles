{
  pkgsUnstable,
  ...
}:

{
  imports = [ ];

  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;
    settings = {
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
      };
    };
  };
}
