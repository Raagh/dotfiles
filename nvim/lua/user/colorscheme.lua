local colorscheme = "tokyonight"
local colorscheme_ok, tokyo = pcall(require, colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

tokyo.setup({
  style = "night";
  on_highlights = function(hl, c)
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark
    }
  end
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

function CreateDAPHighlights()
  vim.highlight.create('DapBreakpoint', { ctermbg = 0, guifg = '#f7768e', guibg = '#1a1b26' }, false)
  vim.highlight.create('DapLogPoint', { ctermbg = 0, guifg = '#449dab', guibg = '#1a1b26' }, false)
  vim.highlight.create('DapStopped', { ctermbg = 0, guifg = '#e0af68', guibg = '#1a1b26' }, false)
end
