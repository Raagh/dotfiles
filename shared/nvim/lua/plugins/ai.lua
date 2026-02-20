return {

  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
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
      {
        "<leader>ai",
        function()
          require("opencode").ask("", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask",
      },
      {
        "<leader>aI",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask with context",
      },
      {
        "<leader>ab",
        function()
          require("opencode").ask("@file ", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask about buffer",
      },
    },
    config = function()
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

  {
    "zbirenbaum/copilot.lua",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LazyVim Extra disabled it for copilot.lua
        copilot = { enabled = true },
      },
    },
  },

  -- {
  --   "mason-org/mason.nvim",
  --   opts = { ensure_installed = { "copilot" } },
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = {
  --     panel = {
  --       enabled = false,
  --     },
  --     suggestion = {
  --       auto_trigger = true,
  --       hide_during_completion = false,
  --     },
  --   },
  -- },
  -- {
  --   "yetone/avante.nvim",
  --   opts = {
  --     windows = {
  --       edit = {
  --         border = "single",
  --       },
  --     },
  --     selection = {
  --       hint_display = "delayed",
  --     },
  --     behaviour = {
  --       auto_apply_diff_after_generation = false,
  --       auto_set_keymaps = false,
  --       auto_focus_sidebar = false,
  --       auto_approve_tool_permissions = false,
  --     },
  --   },
  --   keys = {
  --     { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
  --     {
  --       "<leader>aa",
  --       "<cmd>AvanteAsk<CR>",
  --       desc = "Ask Avante",
  --       mode = { "v", "n", "x" },
  --     },
  --     {
  --       "<leader>ac",
  --       "<cmd>AvanteChat<CR>",
  --       desc = "Chat with Avante",
  --       mode = { "v", "n", "x" },
  --     },
  --     {
  --       "<leader>ae",
  --       "<cmd>AvanteEdit<CR>",
  --       desc = "Edit Avante",
  --       mode = { "v", "n", "x" },
  --     },
  --   },
  -- },
}
