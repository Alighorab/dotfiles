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
  { "lewis6991/gitsigns.nvim", config = true },
  "imsnif/kdl.vim",
}
