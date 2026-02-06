{
  config,
  pkgs,
  pkgsUnstable,
  personalDotfilesPath,
  ...
}:

{
  imports = [ ];

  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;
    agents = {
      backend-architect = builtins.toPath "${personalDotfilesPath}/home-manager/opencode/agents/backend-architect.md";
      database-optimizer = builtins.toPath "${personalDotfilesPath}/home-manager/opencode/agents/database-optimizer.md";
      frontend-developer = builtins.toPath "${personalDotfilesPath}/home-manager/opencode/agents/frontend-developer.md";
    };
    settings = {
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
      };
    };
  };

  home.file = {
    ".config/opencode/skills/".source =
      config.lib.file.mkOutOfStoreSymlink "${personalDotfilesPath}/home-manager/opencode/skills/";
  };
}
