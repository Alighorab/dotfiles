local peek = require("peek")
peek.setup()

vim.keymap.set("n", "<leader>pp", require("peek").open, { buffer = true })
vim.keymap.set("n", "<leader>pc", require("peek").close, { buffer = true })
