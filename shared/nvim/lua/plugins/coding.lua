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
    "mfussenegger/nvim-dap",
    config = function()
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

      for _, language in ipairs({ "typescript", "javascript" }) do
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
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
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
          jestCommand = "yarn test",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            end

            if string.find(file, "/services/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            end

            return vim.fn.getcwd() .. "/jest.config.js"
          end,
          cwd = function()
            local file = vim.fn.expand("%:p")

            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end

            if string.find(file, "/services/") then
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
