return {
  -- {
  --   "LazyVim/LazyVim",
  --   priority = 100,
  --   opts = function(_, _)
  --     -- this doesn't work, need to figure it out
  --     vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define(
  --       "DapBreakpointCondition",
  --       { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
  --     )
  --     vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define(
  --       "DapStopped",
  --       { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
  --     )
  --   end,
  -- },

  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader>b{",
        function()
          require("bufferline").move(-1)
        end,
        desc = "Move Buffer Left",
      },
      {
        "<leader>b}",
        function()
          require("bufferline").move(1)
        end,
        desc = "Move Buffer Right",
      },
    },
    opts = {
      options = {
        custom_filter = function(bufnr)
          local bt = vim.bo[bufnr].buftype
          if bt == "terminal" then
            return false
          end

          return true
        end,
        buffer_close_icon = "✕",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "Request textDocument/inlayHint failed",
          },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
        -- command_palette = {
        --   views = {
        --     cmdline_popup = {
        --       position = {
        --         row = "50%",
        --       },
        --     },
        --   },
        -- },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
      win = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        backdrop = 100,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },

      -- servers = {
      --   vtsls = {
      --     settings = {
      --       typescript = {
      --         tsserver = {
      --           maxTsServerMemory = 8192,
      --         },
      --         vtsls = {
      --           -- autoUseWorkspaceTsdk = true, -- Use workspace TypeScript version
      --           experimental = {
      --             completion = {
      --               enableServerSideFuzzyMatch = true,
      --               entriesLimit = 1000, -- Limit completion entries for performance
      --             },
      --           },
      --         },
      --         preferences = {
      --           includePackageJsonAutoImports = "off",
      --         },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
