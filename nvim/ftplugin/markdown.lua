local peek = require("peek")

vim.keymap.set("n", "<leader>pp", peek.open, { buffer = true, desc = "Peek Open Preview" })
vim.keymap.set("n", "<leader>pc", peek.close, { buffer = true, desc = "Peek Close Preview" })
