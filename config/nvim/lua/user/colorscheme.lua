local colorscheme = "catppuccin"
local colorscheme_ok, cat = pcall(require, colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.g.tokyonight_style = "night"

cat.setup({
  term_colors = true,
  integrations = {
    which_key = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    nvimtree = {
      enabled = true,
    },
    barbar = true,
    treesitter = true,
    cmp = true,
    dashboard = true,
    telescope = true
  }
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

function CreateDAPHighlights()
  -- vim.api.nvim_set_hl('DapBreakpoint', { ctermbg = 0, fg = '#f7768e', bg = '#1a1b26' })
  -- vim.api.nvim_set_hl('DapLogPoint', { ctermbg = 0, fg = '#449dab', bg = '#1a1b26' })
  -- vim.api.nvim_set_hl('DapStopped', { ctermbg = 0, fg = '#e0af68', bg = '#1a1b26' })

  local colors = require("catppuccin.palettes").get_palette()
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = colors.yellow, bg = '#31353f' })
end
