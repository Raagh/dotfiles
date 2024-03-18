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
    },
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
    keys = {
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
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
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", false },
      { "<leader>,", false },
      { "<leader><space>", false },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last search",
      },
      {
        "<leader>fg",
        function()
          local defaultConfig = require("telescope.config").values
          local arguments = table.insert(defaultConfig.vimgrep_arguments, "--fixed-strings")
          require("telescope.builtin").live_grep({ hidden = true, vim_grep_arguments = arguments })
        end,
        desc = "Live grep",
      },
    },
    opts = {
      pickers = {
        find_files = {
          previewer = false,
          hidden = true,
          theme = "dropdown",
        },
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        colorscheme = {
          enable_preview = true,
        },
        defaults = {
          vimgrep_arguments = function()
            local defaultConfig = require("telescope.config").values
            return table.insert(defaultConfig.vimgrep_arguments, "--fixed-strings")
          end,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local win_opt = {
        border = "single",
        col_offset = 0,
        side_padding = 1,
        winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      local doc_opt = {
        col_offset = 0,
        side_padding = 1,
        winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      opts.window = {
        completion = cmp.config.window.bordered(win_opt),
        documentation = cmp.config.window.bordered(doc_opt),
      }
      opts.experimental = {
        ghost_text = false,
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    enabled = false,
  },
}
