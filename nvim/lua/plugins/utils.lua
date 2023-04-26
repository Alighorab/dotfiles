return {
  "mbbill/undotree",
  {
    "vim-scripts/ReplaceWithRegister",
    config = function()
      vim.cmd('nmap gR "+gr')
      vim.cmd('vmap gR "+gr')
    end,
  },
  { "ethanholz/nvim-lastplace", config = true },
  { "numToStr/Comment.nvim", config = true },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk" }, -- a table with mappings to use
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
      keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    },
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["zh"] = "actions.toggle_hidden",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
    cmd = "Oil",
  },
  {
    "Alighorab/stackmap.nvim",
  },
}
