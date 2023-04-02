local colorschemeName = "rose-pine"
local colorscheme_ok, colorscheme = pcall(require, colorschemeName)
if not colorscheme_ok then
  return
end

colorscheme.setup({
  disable_float_background = true,
  highlight_groups = {
    TelescopeBorder = { bg = 'surface', fg = 'surface'},
    TelescopeNormal = { bg = 'surface' },
    TelescopePromptNormal = { bg = 'surface' },
  }
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorschemeName)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

function CreateDAPHighlights()
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#eb6f92', bg = '#191724' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#9ccfd8', bg = '#191724' })
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#f6c177', bg = '#191724' })
end
