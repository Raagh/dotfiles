-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
  cursorlineopt = "line", -- highlight only the text line
  pumblend = 0, -- popup menu transparency
  winblend = 0, -- window transparency
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end
