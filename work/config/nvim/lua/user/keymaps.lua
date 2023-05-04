local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- keep copy when pasting multiple times
keymap("x", "<leader>p", "\"_dP", opts)

-- Clean search highlights
keymap("n", "<F3>", ":noh<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Center C-d and C-u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "U", "<C-r>", opts)

-- Fold
keymap("n", "fc", ":foldclose<CR>", opts)
keymap("n", "fo", ":foldopen<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)

-- Re-order to previous/next
keymap('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', ':BufferMoveNext<CR>', opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
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
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)

-- VSCODE style debugging
keymap("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<cr>", opts)
keymap("n", "<F12>", "<cmd>lua require('dap').step_out()<cr>", opts)
