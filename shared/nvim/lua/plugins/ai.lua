return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = {},
          terminal = {},
        },
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          require("opencode").toggle()
        end,
        mode = { "n" },
        desc = "Toggle OpenCode",
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          snacks = {
            win = {
              enter = true,
            },
          },
        },
      }

      vim.o.autoread = true
    end,
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   enabled = false,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       -- LazyVim Extra disabled it for copilot.lua
  --       copilot = { enabled = true },
  --     },
  --   },
  -- },
}
