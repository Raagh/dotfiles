return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer",
      },
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c)
    end,
  },
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
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
        documentation = {
          window = {
            border = "rounded",
            winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
        -- ghost_text = {
        --   enabled = false,
        -- },
        -- trigger = {
        --   show_on_insert_on_trigger_character = false,
        -- },
      },
    },
  },
}
