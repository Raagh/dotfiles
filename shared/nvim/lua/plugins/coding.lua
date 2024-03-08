return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.tsserver.root_dir = require("lspconfig.util").root_pattern(".git")
    end,
  },
}
