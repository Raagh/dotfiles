return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = {
        eslint = {},
        vtsls = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
          },
        },
      }

      opts.setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "vtsls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      }

      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.diagnostic.config({
        float = { border = "rounded" },
      })
    end,
  },
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
}
