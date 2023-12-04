local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<C-a>", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<S-y>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<S-u>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<S-i>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<S-o>", function() harpoon:list():select(4) end)
