local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<F6>", function ()
    vim.cmd("write")
    vim.cmd("!cargo build")
end)
