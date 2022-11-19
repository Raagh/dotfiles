local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local nvim_tree_shift = {
  function()
    return string.rep(' ',
      vim.api.nvim_win_get_width(require 'nvim-tree.view'.get_winnr()) - 1)
  end,
  cond = require('nvim-tree.view').is_visible,
  color = 'NvimTreeNormal'
}

lualine.setup({
  extensions = { 'nvim-tree', 'toggleterm', 'nvim-dap-ui' },
  options = {
    theme = 'tokyonight',
    globalstatus = true,
    refresh = {
      statusline = 100,
    }
  },
  sections = {
    lualine_a = { nvim_tree_shift, "mode" }
  },
})
