local colorscheme = "tokyonight"
local colorscheme_ok, tokyo = pcall(require, colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

tokyo.setup({
  style = "night"
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

function CreateDAPHighlights()
  vim.highlight.create('DapBreakpoint', { ctermbg = 0, guifg = '#993939', guibg = '#31353f' }, false)
  vim.highlight.create('DapLogPoint', { ctermbg = 0, guifg = '#61afef', guibg = '#31353f' }, false)
  vim.highlight.create('DapStopped', { ctermbg = 0, guifg = '#98c379', guibg = '#31353f' }, false)
end
