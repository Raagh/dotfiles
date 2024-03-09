-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local del_keymap = vim.keymap.del
local set_keymap = vim.keymap.set

-- Center C-d and C-u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Center search results
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- The control-shift-z of nvim
keymap("n", "U", "<C-r>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)

-- Launch lazygit as full screen
local Util = require("lazyvim.util")
set_keymap("n", "<leader>gg", function()
  Util.terminal.open({ "lazygit" }, {
    size = {
      width = 1,
      height = 1,
    },
    border = "none",
  })
end, { desc = "Lazygit" })

-- REMOVE DEFAULT KEYMAPS

-- tabs
del_keymap("n", "<leader><tab>l", opts)
del_keymap("n", "<leader><tab>f", opts)
del_keymap("n", "<leader><tab><tab>", opts)
del_keymap("n", "<leader><tab>]", opts)
del_keymap("n", "<leader><tab>d", opts)
del_keymap("n", "<leader><tab>[", opts)

--  weird ones
del_keymap("n", "<leader>K", opts)
del_keymap("n", "<leader>L", opts)

-- terminal
del_keymap("n", "<leader>ft", opts)
del_keymap("n", "<leader>fT", opts)
