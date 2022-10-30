local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

vnoremap("<leader>fm", function ()
    vim.cmd("!fmt -w 79")
end)
nnoremap("<leader>ht", function ()
    vim.cmd("!grip --export %<CR><CR>")
end)
