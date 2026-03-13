return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<c-/>",
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
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
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
      "marilari88/neotest-vitest",
    },
    opts = require("raagh.neotest"),
  },
}
