return {
  -- Nvim Treesitter configurations and abstraction layer
  -- Treesitter:
  --   An incremental parsing system for programming tools.
  --   It can build a concrete syntax tree for a source file
  --   and efficiently update the syntax tree as the source file
  --   is edited.
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "andymass/vim-matchup",
  "HiPhish/nvim-ts-rainbow2",
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
}
