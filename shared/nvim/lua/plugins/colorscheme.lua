local system = require("utils.system")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = system.is_nixos() and "rose-pine" or "kanagawa",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_highlights = function(hl, c) end,
    },
  },
  {
    "catppuccin/catppuccin",
    enabled = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = function()
      local _, palette = pcall(require, "rose-pine.palette")
      return {
        disable_float_background = true,
        highlight_groups = {
          -- vim.api.nvim_set_hl(0, "PopMenu", { bg = theme.ui.bg, blend = 0 })

          DapBreakpoint = {
            fg = palette.love,
            bg = palette.base,
          },
          DapLogPoint = {
            fg = palette.iris,
            bg = palette.base,
          },
          DapStopped = {
            fg = palette.gold,
            bg = palette.base,
          },
          NormalFloat = { bg = palette.base }, -- All floating buffers background like the lsp, autocomplete and such
          FloatBorder = { bg = palette.base, fg = palette.love }, -- Most floating borders except telescope
          FloatTitle = { bg = palette.base, fg = palette.gold },
          NeotreeFloatTitle = { bg = palette.base, fg = palette.gold },
          WhichKeyFloat = { bg = palette.base }, -- Whichkey popup background
          WhichKeyTitle = { bg = palette.base, fg = palette.gold }, -- Whichkey popup background
          WhichKeyBorder = { bg = palette.base, fg = palette.love }, -- Whichkey border popup
          NotifyWARNBorder = { bg = palette.base },
          NotifyERRORBorder = { bg = palette.base },
          NotifyINFOBorder = { bg = palette.base },
        },
      }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      defaults = {
        hidden = true,
      },
      winopts = {
        backdrop = 100,
      },
      hls = {
        title = "FloatTitle",
        backdrop = 100,
        border = "FloatBorder",
        preview_border = "FloatBorder",
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "wave",
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

        return {
          DapBreakpoint = {
            fg = palette.waveRed,
            bg = "none",
          },
          VertSplit = {
            fg = palette.waveAqua2,
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
          FloatBorder = { bg = "none", fg = palette.autumnGreen }, -- Most floating borders except telescope
          FloatTitle = { bg = "none", fg = palette.boatYellow2 }, -- Title for the rename and lsp windows (dressing.nvim)
          NeotreeFloatTitle = { bg = "none", fg = palette.boatYellow2 }, -- Title for the rename and lsp windows (dressing.nvim)
          LazyDimmed = { bg = "none", fg = "none" },
        }
      end,
    },
  },
}
