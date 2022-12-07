local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local markdown = require("markdown")

local bufopts = { silent = true, buffer = true }

vnoremap("<leader>mf", function ()
    vim.cmd("!fmt -w 79")
end, bufopts)

nnoremap("<leader>mg", function ()
    markdown.spawn_server()
    markdown.spawn_browser()
end, bufopts)

nnoremap("<leader>mk", function ()
    markdown.kill_server()
    markdown.kill_browser()
end, bufopts)
