return {
  {
    "LazyVim/LazyVim",
    priority = 100,
    opts = function(_, _)
      -- this doesn't work, need to figure it out
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,
  },

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
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
      spec = {
        {
          "<leader>ur",
          "<cmd>:e %<cr>",
          desc = "Reload File",
        },
        {
          mode = { "n", "v" },
          { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
        },
      },
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
    "folke/flash.nvim",
    opts = {
      modes = {
        -- Disable labels for regular search with `/`
        search = {
          enabled = false,
        },
        -- Disable labels for motions like f, t, F, T
        char = {
          enabled = false,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(opts, _)
      opts.servers = {
        vtsls = {
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
          },
        },
      }

      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.diagnostic.config({
        float = { border = "rounded" },
      })
    end,
  },
}
