vim.keymap.set("n", "<leader>hm", function()
  require("harpoon.mark").add_file()
end, { silent = true, desc = "Harppon Add File" })

vim.keymap.set("n", "<leader>hu", function()
  require("harpoon.ui").toggle_quick_menu()
end, { silent = true, desc = "Harppon Quick Menu Toggle" })

vim.keymap.set("n", "<C-j>", function()
  require("harpoon.ui").nav_file(1)
end, { silent = true, desc = "Harppon Navigate File (1)" })

vim.keymap.set("n", "<C-f>", function()
  require("harpoon.ui").nav_file(2)
end, { silent = true, desc = "Harppon File (2)" })

vim.keymap.set("n", "<C-h>", function()
  require("harpoon.ui").nav_file(3)
end, { silent = true, desc = "Harppon File (3)" })

vim.keymap.set("n", "<C-g>", function()
  require("harpoon.ui").nav_file(4)
end, { silent = true, desc = "Harppon File (4)" })
