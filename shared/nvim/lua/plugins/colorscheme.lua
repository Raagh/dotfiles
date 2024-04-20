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
        -- hl.BufferLineBackground.bg = c.bg
        -- hl.BufferLineFill.bg = c.bg

        -- vim.api.nvim_set_hl(0, "PopMenu", { bg = c.bg, blend = 0 }) --Remove transparency and set background of completion popup
      end,
    },
  },
  {
    "catppuccin/catppuccin",
    enabled = false,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = function()
      local rose_pine_palette_ok, palette = pcall(require, 'rose-pine.palette')
      return {
          disable_float_background = true,
          highlight_groups = { 
            -- vim.api.nvim_set_hl(0, "PopMenu", { bg = theme.ui.bg, blend = 0 })

            -- Only setup the only ones needed
            --
              DapBreakpoint = {
                fg = palette.love,
                bg = palette.base, 
              },
              DapLogPoint = {
                fg = palette.iris,
                bg = palette.base ,
              },
              DapStopped = {
                fg = palette.gold,
                bg = palette.base ,
              },
              NormalFloat = { bg = palette.base }, -- All floating buffers background like the lsp, autocomplete and such
              FloatBorder = { bg = palette.base, fg = palette.muted }, -- Most floating borders except telescope
              WhichKeyFloat = { bg = palette.base }, -- Whichkey popup background
              -- FloatTitle = { bg = palette.base }, -- Title for the rename and lsp windows (dressing.nvim)
              -- LazyDimmed = { bg = palette.base, fg = palette.base },
              TelescopeBorder = { bg = palette.base, fg = palette.love },
              TelescopeTitle = { bg = palette.base, fg = palette.gold },
              TelescopeResultsNormal = { bg = palette.base, fg = palette.text },
              -- LazyNormal = { bg = "red" }, -- Title for the rename and lsp windows (dressing.nvim)
              -- BufferLineBackground = { bg = theme.ui.bg_dim },
              -- BufferLineFill = { bg = theme.ui.bg_dim },
          },
        }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
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
          NormalFloat = { bg = theme.ui.bg }, -- All floating buffers background like the lsp, autocomplete and such
          FloatBorder = { bg = "none" }, -- Most floating borders except telescope
          TelescopeBorder = { bg = "none" },
          FloatTitle = { bg = "none" }, -- Title for the rename and lsp windows (dressing.nvim)
          LazyDimmed = { bg = "none", fg = "none" },
          -- LazyNormal = { bg = "red" }, -- Title for the rename and lsp windows (dressing.nvim)
          -- BufferLineBackground = { bg = theme.ui.bg_dim },
          -- BufferLineFill = { bg = theme.ui.bg_dim },
        }
      end,
    },
  },
}
