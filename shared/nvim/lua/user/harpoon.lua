local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  return
end

harpoon:setup({
  settings = {
    ui_width_ratio = 0.3,
    save_on_toggle = true,
  }
})

vim.keymap.set("n", "<S-i>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<S-o>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<S-p>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<S-{>", function() harpoon:list():select(4) end)
