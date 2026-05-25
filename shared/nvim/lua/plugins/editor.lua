local headers = require("raagh.dashboard-headers")
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
      styles = {
        news = {
          border = "rounded",
        },
      },
      win = {
        backdrop = 100,
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
          header = table.concat(headers.neovim, "\n"),
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
