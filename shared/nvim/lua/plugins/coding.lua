return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = {
        eslint = {},
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
        },
      }
      opts.setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      }

      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
}
