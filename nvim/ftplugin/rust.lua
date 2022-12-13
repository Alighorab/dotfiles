local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap
local bufopts = { silent = true, buffer = true }

nnoremap("<F6>", function ()
    vim.cmd.write()
    vim.cmd("!cargo build")
end, bufopts)
