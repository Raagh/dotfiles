-- vim.g.tokyonight_style = "night"
local catppuccin_ok, cat = pcall(require, "catppuccin")
if not catppuccin_ok then
  vim.notify("colorscheme " .. "catppuccin" .. " not found!")
  return
end


vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

cat.setup({
  term_colors = true,
  integrations = {
    which_key = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    barbar = true,
    treesitter = true,
    cmp = true,
    dashboard = true,
    telescope = true
  }
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. "catppuccin")
if not status_ok then
  vim.notify("colorscheme " .. "catppuccin" .. " not found!")
  return
end

function CreateDAPHighlights()
-- vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#993939', guibg='#31353f' }, false)
-- vim.highlight.create('DapLogPoint', { ctermbg=0, guifg='#61afef', guibg='#31353f' }, false)
-- vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379', guibg='#31353f' }, false)

  local colors = require("catppuccin.palettes").get_palette()
  vim.highlight.create('DapStopped', { ctermbg = 0, guifg = colors.yellow, guibg = '#31353f' }, false)
end
