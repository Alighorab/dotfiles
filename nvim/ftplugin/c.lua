local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap

-- Compile
nnoremap("<F6>", function()
    local filename = vim.fn.expand("%")
    local basename = vim.fn.expand('%:t:r')
    local handle = io.popen("(ls | grep -i makefile)")
    local makefile

    if handle then
        makefile = handle:read("*a")
    else
        return 1
    end

    if makefile ~= "" then
        os.execute("make")
    else
        os.execute(string.format("gcc -g -o %s %s", basename, filename))
    end
    handle:close()
    vim.cmd("echo " .. "\"" .. string.format("Compiled %s to %s", filename, basename) .. "\"")
end)
