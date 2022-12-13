-- Make the cursor shape as block
vim.opt.guicursor = ""
-- line and relativeline number
vim.opt.nu = true
vim.opt.relativenumber = true
-- OBVIOUS
vim.opt.errorbells = false
-- Set tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- Don't wrap lines when it reached the border
vim.opt.wrap = false
-- Works fantastic with undotree plugin
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- REMOVE highlighting after finishing the search command
vim.opt.hlsearch = false
-- Show search matches while typing
vim.opt.incsearch = true
-- Set file encoding
vim.opt.encoding = "utf8"
-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true
-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- Remember not to excede 79 characters in one line!
vim.opt.colorcolumn = "80"
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50
-- Disable mouse entirely
vim.opt.mouse = ""
-- Don't show mode
vim.opt.showmode = false
-- open help in vertical split
vim.cmd("cabbrev h vert h")
-- Map leader key to <space>
vim.g.mapleader = " "
