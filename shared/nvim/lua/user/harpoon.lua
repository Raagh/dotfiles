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

vim.keymap.set("n", "<A-<>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<A->>", function() harpoon:list():next() end)
