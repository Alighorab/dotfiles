return {
  "CRAG666/code_runner.nvim",
  opts = function()
    return {
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
      startinsert = true,
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
      project = {},
      project_path = "",
    }
  end,
  config = true,
  keys = {
    { "<F5>", ":RunCode<CR>", desc = "Run Code" },
  },
}
