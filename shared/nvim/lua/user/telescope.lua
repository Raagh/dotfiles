local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require 'telescope.actions'
local defaultConfig = require'telescope.config'.values
local tb = require'telescope.builtin'

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local keymap = vim.keymap.set

keymap('v', '<C-g>',
  function()
    local text = vim.getVisualSelection()
    tb.live_grep({ default_text = text })
  end, { noremap = true, silent = true })

telescope.setup {
  pickers = {
    find_files = {
      previewer = false,
      hidden = true
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions_list = { "themes", "terms" },
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    vimgrep_arguments = table.insert(defaultConfig.vimgrep_arguments, '--fixed-strings'),
    file_ignore_patterns = { "node_modules" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
