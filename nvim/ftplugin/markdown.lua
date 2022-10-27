local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

vnoremap("<leader>fm", vim.cmd("!fmt -w 79"))
nnoremap("<leader>ht", vim.cmd("!grip --export %<CR><CR>"))
