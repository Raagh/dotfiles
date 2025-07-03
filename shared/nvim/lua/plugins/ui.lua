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
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      --   Warn  15:34:01 notify.warn DAP Debug adapter didn't respond. Either the adapter is slow (then wait and ignore this) or there is a problem with your adapter or `pwa-node` configuration. Check the logs for errors (:help dap.set_log_level)
      table.insert(opts.routes, {
        filter = {
          event = "dap",
          find = "Debug adapter didn't respond. Either the adapter is slow (then wait and ignore this) or there is a problem with your adapter or `pwa-node` configuration. Check the logs for errors (:help dap.set_log_level)",
        },
        opts = { skip = true },
      })

      opts.presets = {
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
      }
    end,
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
      },
      win = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
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
}
