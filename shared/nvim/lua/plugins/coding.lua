return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<c-/>",
        enabled = false,
      },
      {
        "<c-_>",
        enabled = false,
      },
    },
    opts = {
      win = {
        backdrop = 100,
        -- for reference this is how you link a highlight group for a window
        -- wo = {
        -- winhighlight = "FloatTitle:Title",
        -- },
      },
      -- picker = {
      --   sources = {
      --     grep = {
      --       regex = false,
      --     },
      --   },
      -- },
      image = {
        enabled = true,
      },
      scroll = {
        enabled = false,
      },
      lazygit = {
        win = {
          height = 0,
          width = 0,
        },
      },
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1,
            cmd = "hub status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local dap = require("dap")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("js-debug-adapter"),
          args = { "${port}" },
        },
      }

      for _, language in ipairs(languages) do
        local defaultConfig = dap.configurations[language]
        local newConfig = {
          {
            name = "Debug -> watch:node",
            request = "launch",
            runtimeArgs = {
              "watch:node",
            },
            runtimeExecutable = "yarn",
            skipFiles = {
              "<node_internals>/**",
            },
            type = "pwa-node",
            envFile = "${workspaceFolder}/.env.local",
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
        for _, v in ipairs(defaultConfig) do
          table.insert(newConfig, v)
        end

        dap.configurations[language] = newConfig
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    opts = {
      discovery = {
        enabled = false,
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      floating = {
        border = "rounded",
      },
      adapters = {
        ["neotest-jest"] = {
          jest_test_discovery = true,
          jestCommand = "yarn test",
          cwd = function(file)
            if
              string.find(file, "/services/")
              or string.find(file, "/packages/")
              or string.find(file, "/scripts/")
              or string.find(file, "/frontend/")
            then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
      },
      summary = {
        open = "topleft vsplit | vertical resize 50",
      },
    },
  },

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
        "<leader>aa",
        function()
          require("opencode").toggle()
        end,
        mode = { "n" },
        desc = "Toggle OpenCode",
      },
      {
        "<leader>as",
        function()
          require("opencode").select({ submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode select",
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
  --       keymap = {
  --         accept = "<Tab>",
  --       },
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
