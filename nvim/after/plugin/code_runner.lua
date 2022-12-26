local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap

require("code_runner").setup({
  -- put here the commands by filetype
  filetype = {
    python = "python3 -u",
    c = "gcc -o $fileNameWithoutExt -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt",
    cpp = "g++ -o $fileNameWithoutExt -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt",
    go = "go run $fileName",
    lua = "luajit $fileName",
    rust = "cargo run",
  },
  mode = "toggle",
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
  },
})

local commands = require("code_runner.commands")

nnoremap("<F5>", commands.run_code)
nnoremap("<F17>", commands.run_close) -- Shift <F5>
