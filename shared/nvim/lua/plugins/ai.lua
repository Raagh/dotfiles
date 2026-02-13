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
      {
        "<leader>a",
        desc = "ai",
      },
      {
        "<leader>ao",
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
      {
        "<leader>ap",
        function()
          require("opencode").prompt("@this", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode prompt",
      },
      -- Built-in prompts
      {
        "<leader>ape",
        function()
          require("opencode").prompt("explain", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode explain",
      },
      {
        "<leader>apf",
        function()
          require("opencode").prompt("fix", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode fix",
      },
      {
        "<leader>apd",
        function()
          require("opencode").prompt("diagnose", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode diagnose",
      },
      {
        "<leader>apr",
        function()
          require("opencode").prompt("review", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode review",
      },
      {
        "<leader>apt",
        function()
          require("opencode").prompt("test", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode test",
      },
      {
        "<leader>apo",
        function()
          require("opencode").prompt("optimize", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode optimize",
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
  --       auto_set_keymaps = false,
  --       auto_focus_sidebar = false,
  --       auto_approve_tool_permissions = false,
  --     },
  --     providers = {
  --       copilot = {
  --         model = "claude-sonnet-4",
  --       },
  --     },
  --   },
  -- },
}
