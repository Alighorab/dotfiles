setlocal cindent
nmap <silent> <leader>gh <cmd>CocCommand clangd.switchSourceHeader<CR>

lua << END

local Remap = require("keymap")
local nnoremap = Remap.nnoremap

-- Compile
nnoremap("<F6>", function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%")
    local basename = vim.fn.expand('%:t:r')
    local handle = io.popen("(ls | grep -i makefile)")
    local makefile = handle:read("*a")
    if makefile ~= "" then
        os.execute("make")
    else
        if filetype == "c" then
            os.execute(string.format("gcc -g -o %s %s", basename, filename))
        else
            os.execute(string.format("g++ -g -o %s %s", basename, filename))
        end
    end
    handle:close()
    vim.cmd("echo " .. "\"" .. string.format("Compiled %s to %s", filename, basename) .. "\"")
end)

END
