return {
  {
    "segeljakt/vim-silicon",
    cmd = "Silicon",
    config = function()
      vim.cmd([[
      let g:silicon = {
      \   'theme': 'Solarized (light)',
      \   'font': 'Fira Code',
      \   'background': '#AAAAFF',
      \   'shadow-color': '#555555',
      \   'line-pad': 2,
      \   'pad-horiz': 0,
      \   'pad-vert': 0,
      \   'shadow-blur-radius': 0,
      \   'shadow-offset-x': 0,
      \   'shadow-offset-y': 0,
      \   'line-number': v:true,
      \   'round-corner': v:false,
      \   'window-controls': v:true,
      \ }
      ]])
    end,
  },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
            name = "[Neorg]",
          },
        },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
