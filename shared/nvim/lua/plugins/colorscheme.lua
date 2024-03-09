return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
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
        hl.NormalFloat.bg = c.bg
        hl.WhichKeyFloat.bg = c.bg
        hl.FloatBorder.bg = c.bg
        hl.TelescopeBorder.bg = c.bg
        hl.TelescopeNormal.bg = c.bg
        hl.NeoTreeNormal.bg = c.bg
        hl.LspInfoBorder.bg = c.bg

        vim.api.nvim_set_hl(0, "PopMenu", { bg = c.bg, blend = 0 })
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
      transparent = true,
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
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          TelescopeBorder = { bg = "none" },
        }
      end,
    },
  },
}
