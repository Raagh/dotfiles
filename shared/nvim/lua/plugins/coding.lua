return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.tsserver.root_dir = require("lspconfig.util").root_pattern(".git")
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
}
