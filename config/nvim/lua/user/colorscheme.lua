local colorscheme = "tokyonight"
local colorscheme_ok, tokyo = pcall(require, colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.g.tokyonight_style = "night"

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
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#f7768e', bg = '#1a1b26' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#449dab', bg = '#1a1b26' })
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#e0af68', bg = '#1a1b26' })
end
