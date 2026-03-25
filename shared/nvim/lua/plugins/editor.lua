return {
  -- {
  --   "LazyVim/LazyVim",
  --   priority = 100,
  --   opts = function(_, _)
  --     -- this doesn't work, need to figure it out
  --     vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define(
  --       "DapBreakpointCondition",
  --       { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
  --     )
  --     vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
  --     vim.fn.sign_define(
  --       "DapStopped",
  --       { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
  --     )
  --   end,
  -- },

  {
    "folke/snacks.nvim",
    keys = {
      {
        "<c-/>",
        enabled = false,
      },
    },
    opts = {
      styles = {
        news = {
          border = "rounded",
        },
      },
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
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader>b{",
        function()
          require("bufferline").move(-1)
        end,
        desc = "Move Buffer Left",
      },
      {
        "<leader>b}",
        function()
          require("bufferline").move(1)
        end,
        desc = "Move Buffer Right",
      },
    },
    opts = {
      options = {
        custom_filter = function(bufnr)
          local bt = vim.bo[bufnr].buftype
          if bt == "terminal" then
            return false
          end

          return true
        end,
        buffer_close_icon = "✕",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "Request textDocument/inlayHint failed",
          },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
      win = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        backdrop = 100,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },

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
}
