return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.DapBreakpoint = {
          fg = c.red,
          bg = c.bg,
        }
        hl.DapLogPoint = {
          fg = c.cyan,
          bg = c.bg,
        }
        hl.DapStopped = {
          fg = c.yellow,
          bg = c.bg,
        }
        hl.NormalFloat.bg = c.bg -- All floating buffers background like the lsp, autocomplete and such
        hl.WhichKeyFloat.bg = c.bg -- Whichkey popup background
        hl.FloatBorder.bg = c.bg -- Most floating borders except telescope
        hl.TelescopeBorder.bg = c.bg
        hl.TelescopeNormal.bg = c.bg
        hl.NeoTreeNormal.bg = c.bg --Neotree background
        hl.LspInfoBorder.bg = c.bg --Border for the LSPInfo window, leader + c + l
        hl.FloatTitle.bg = c.bg -- Title for the rename and lsp windows (dressing.nvim)
        hl.BufferLineBackground.bg = c.bg
        hl.BufferLineFill.bg = c.bg

        -- vim.api.nvim_set_hl(0, "PopMenu", { bg = c.bg, blend = 0 }) --Remove transparency and set background of completion popup
      end,
    },
  },
  {
    "catppuccin/catppuccin",
    enabled = false,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    opts = {
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local palette = colors.palette
        local theme = colors.theme
        -- vim.api.nvim_set_hl(0, "PopMenu", { bg = theme.ui.bg, blend = 0 })

        -- Only setup the only ones needed
        --
        return {
          DapBreakpoint = {
            fg = palette.waveRed,
            bg = "none",
          },
          DapLogPoint = {
            fg = palette.waveAqua2,
            bg = "none",
          },
          DapStopped = {
            fg = palette.boatYellow2,
            bg = "none",
          },
          NormalFloat = { bg = "none" }, -- All floating buffers background like the lsp, autocomplete and such
          FloatBorder = { bg = "none" }, -- Most floating borders except telescope
          TelescopeBorder = { bg = "none" },
          FloatTitle = { bg = "none" }, -- Title for the rename and lsp windows (dressing.nvim)
          BufferLineBackground = { bg = theme.ui.bg_dim },
          BufferLineFill = { bg = theme.ui.bg_dim },
        }
      end,
    },
  },
}
