-- Basic configuration for vscode-neovim
local M = {}

-- Load shared configurations
require("logan.set")
require("logan.remaps")

-- Load only the plugins that work well with vscode-neovim
require("plugins.tpope") -- tpope plugins
require("plugins.harpoon") -- harpoon for quick file navigation
require("plugins.cmp") -- completion
require("plugins.treesitter") -- syntax highlighting
require("plugins.lsp") -- LSP support
require("plugins.misc") -- miscellaneous plugins

-- Add any vscode-specific configurations here
vim.g.mapleader = " " -- Set leader key
vim.g.maplocalleader = " " -- Set local leader key

-- Disable some features that VS Code handles
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Toggle between editor and file explorer
vim.keymap.set("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")

-- Telescope-like keybindings for VS Code
vim.keymap.set("n", "<leader>ff", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")

-- Search in files (like Telescope live_grep)
vim.keymap.set("n", "<leader>fg", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>")

-- Buffer list (like Telescope buffers)
vim.keymap.set("n", "<leader>fb", "<cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>")

-- Command palette (like Telescope commands)
vim.keymap.set("n", "<leader>fc", "<cmd>call VSCodeNotify('workbench.action.showCommands')<CR>")

-- Go to symbol (like Telescope lsp_document_symbols)
vim.keymap.set("n", "<leader>fs", "<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>")

-- Recent files (like Telescope oldfiles)
vim.keymap.set("n", "<leader>fr", "<cmd>call VSCodeNotify('workbench.action.openRecent')<CR>")

-- Regular Neovim remaps that work in vscode-neovim
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>cn", "*``cgn")
vim.keymap.set("n", "<leader>cN", "#``cgN")
vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "5<C-d>")
vim.keymap.set("n", "<C-u>", "5<C-u>")
vim.keymap.set("n", "<leader>n", vim.cmd.enew)
vim.keymap.set("n", "gp", "`[v`]")

-- Visual mode remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")

-- Text objects
vim.keymap.set("x", "il", "g_o^")
vim.keymap.set("o", "il", ":normal vil<cr>")
vim.keymap.set("o", "ie", ":<C-u>normal! ggVG<CR>")
vim.keymap.set("x", "ie", ":<C-u>normal! ggVG<CR>")

-- Copying and pasting from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg$')

-- Quickfix list
vim.keymap.set("n", "<leader>qq", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists then
        vim.cmd.cclose()
    else
        vim.cmd.copen()
    end
end)
vim.keymap.set("n", "<leader>qn", function()
    if not pcall(vim.cmd.cnext) then
        print("QuickFix: No Next Element")
    else
        vim.cmd.normal("zz")
    end
end)
vim.keymap.set("n", "<leader>qp", function()
    if not pcall(vim.cmd.cprevious) then
        print("QuickFix: No Previous Element")
    else
        vim.cmd.normal("zz")
    end
end)
vim.keymap.set("n", "<leader>qo", vim.cmd.copen)

-- Quickfix autocommand
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("QuickFix", {}),
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "zf", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", { buffer = true })
    end,
})

return M 