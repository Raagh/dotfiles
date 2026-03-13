return {
  -- {
  --   "mfussenegger/nvim-dap",
  --   keys = {
  --     { "<leader>dO", false },
  --     { "<leader>db", false },
  --     { "<leader>dl", false },
  --     { "<leader>dg", false },
  --     {
  --       "<leader>dt",
  --       function()
  --         require("dap").toggle_breakpoint()
  --       end,
  --       desc = "Toggle Breakpoint",
  --     },
  --     {
  --       "<F5>",
  --       function()
  --         require("dap").continue()
  --       end,
  --     },
  --     {
  --       "<F10>",
  --       function()
  --         require("dap").step_over()
  --       end,
  --     },
  --     {
  --       "<F11>",
  --       function()
  --         require("dap").step_into()
  --       end,
  --     },
  --     {
  --       "<F12>",
  --       function()
  --         require("dap").step_out()
  --       end,
  --     },
  --   },
  -- opts = function()
  --   local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
  --   local dap = require("dap")
  --   dap.adapters["pwa-node"] = {
  --     type = "server",
  --     host = "localhost",
  --     port = "${port}",
  --     executable = {
  --       command = vim.fn.exepath("js-debug-adapter"),
  --       args = { "${port}" },
  --     },
  --   }
  --
  --   for _, language in ipairs(languages) do
  --     local defaultConfig = dap.configurations[language]
  --     local newConfig = {
  --       {
  --         name = "Debug -> watch:node",
  --         request = "launch",
  --         runtimeArgs = {
  --           "watch:node",
  --         },
  --         runtimeExecutable = "yarn",
  --         skipFiles = {
  --           "<node_internals>/**",
  --         },
  --         type = "pwa-node",
  --         envFile = "${workspaceFolder}/.env.local",
  --         rootPath = "${workspaceFolder}",
  --         cwd = "${workspaceFolder}",
  --         console = "integratedTerminal",
  --         internalConsoleOptions = "neverOpen",
  --       },
  --     }
  --     for _, v in ipairs(defaultConfig) do
  --       table.insert(newConfig, v)
  --     end
  --
  --     dap.configurations[language] = newConfig
  --   end
  -- end,
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover(nil, { border = "rounded" })
        end,
        desc = "Hover",
      },
    },
    opts = {
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.85 },
            { id = "breakpoints", size = 0.15 },
            { id = "watches", size = 0.15 },
            "stacks",
          },
          size = 0.25,
          position = "left",
        },
        {
          elements = {
            "console",
            -- "repl",
          },
          size = 0.30,
          position = "bottom",
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = require("raagh.neotest"),
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       vtsls = {
  --         settings = {
  --           typescript = {
  --             tsserver = {
  --               maxTsServerMemory = 8192,
  --             },
  --             vtsls = {
  --               -- autoUseWorkspaceTsdk = true, -- Use workspace TypeScript version
  --               experimental = {
  --                 completion = {
  --                   enableServerSideFuzzyMatch = true,
  --                   entriesLimit = 1000, -- Limit completion entries for performance
  --                 },
  --               },
  --             },
  --             preferences = {
  --               includePackageJsonAutoImports = "off",
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
