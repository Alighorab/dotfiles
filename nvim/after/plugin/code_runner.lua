local Remap = require("keymap")
local nnoremap = Remap.nnoremap

require('code_runner').setup ({
    -- put here the commands by filetype
    filetype = {
        python = "python3 -u",
        c = "gcc -o $fileNameWithoutExt -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt",
        cpp = "g++ -o $fileNameWithoutExt -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt",
        go = "go run $fileName",
        lua = "lua $fileName",
        rust = "cargo run"
    },
    mode = 'toggle',
    focus = true,
    smartinsert = true,
    float = {
        -- Window border (see ':h nvim_open_win')
        border = "solid",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
    },
    project = {
        ["/home/logan/Study/computer-science-engineering/courses/15-213-Introduction-to-Computer-Systems/lab-solutions/7.ProxyLab/proxylab-handout"] = {
            name = "Proxy",
            description = "A simple, multi-threaded proxy server",
            file_name = "proxy.c",
            command = "make run"
		}
    }
})

nnoremap("<F5>", ":RunCode<CR>")
nnoremap("<F17>", ":RunClose<CR>")
