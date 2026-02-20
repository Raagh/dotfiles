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
      {
        "<leader>E",
        false,
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      filesystem = {
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)

            local sidebar = require("avante").get()

            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end

            sidebar.file_selector:add_selected_file(relative_path)

            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
            end
          end,
        },
        window = {
          mappings = {
            ["oa"] = "avante_add_files",
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dO", false },
      { "<leader>db", false },
      { "<leader>dl", false },
      { "<leader>dg", false },
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
      },
    },
  },
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
      {
        "<leader>du",
        function()
          require("dapui").toggle({ reset = true })
        end,
        desc = "Dap UI",
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
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    opts = {
      enabled = false,
    },
    keys = {
      {
        "<leader>go",
        "<cmd>GitBlameOpenCommitURL<cr>",
        desc = "Open Commit In Browser",
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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add latex, needed for markdown for whatever reason
      vim.list_extend(opts.ensure_installed, {
        -- "latex",
        "prisma",
      })
    end,
  },
}
