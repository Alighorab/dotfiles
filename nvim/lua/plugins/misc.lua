return {
  {
    "toppair/peek.nvim",
    ft = "markdown",
    opts = { autoload = true },
    config = function(_, opts)
      local peek = require("peek")
      peek.setup(opts)
      vim.keymap.set("n", "<leader>pp", peek.open, { buffer = true, desc = "Peek Open Preview" })
      vim.keymap.set("n", "<leader>pc", peek.close, { buffer = true, desc = "Peek Close Preview" })
    end,
  },
  { "segeljakt/vim-silicon", cmd = "Silicon" },
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
