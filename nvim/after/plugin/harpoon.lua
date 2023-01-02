vim.keymap.set("n", "<leader>hm", function()
  require("harpoon.mark").add_file()
end, { silent = true, desc = "Harppon Add File" })

vim.keymap.set("n", "<leader>hu", function()
  require("harpoon.ui").toggle_quick_menu()
end, { silent = true, desc = "Harppon Quick Menu Toggle" })

vim.keymap.set("n", "<A-1>", function()
  require("harpoon.ui").nav_file(1)
end, { silent = true, desc = "Harppon Navigate File (1)" })

vim.keymap.set("n", "<A-2>", function()
  require("harpoon.ui").nav_file(2)
end, { silent = true, desc = "Harppon File (2)" })

vim.keymap.set("n", "<A-3>", function()
  require("harpoon.ui").nav_file(3)
end, { silent = true, desc = "Harppon File (3)" })

vim.keymap.set("n", "<A-4>", function()
  require("harpoon.ui").nav_file(4)
end, { silent = true, desc = "Harppon File (4)" })
