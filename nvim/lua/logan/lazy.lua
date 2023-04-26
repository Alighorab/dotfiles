-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local opts = {
  concurrency = 4, ---@type number limit the maximum amount of concurrent tasks
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "catppuccin" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "netrwPlugin",
        "zipPlugin",
      },
    },
  },
}

-- Map leader key to <space>
vim.g.mapleader = " "

require("lazy").setup("plugins", opts)

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { silent = true })
