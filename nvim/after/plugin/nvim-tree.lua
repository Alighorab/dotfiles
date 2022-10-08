local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local silent = { silent = true }

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    auto_reload_on_write = true,
    view = {
        adaptive_size = false,
        relativenumber = true,
        float = {
            enable = true,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 60,
                height = 24,
                row = 8,
                col = 60,
            }
        }
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
        custom = { "^.git$" }
    },
    diagnostics = {
        enable = true,
        icons = { hint = "", info = "", warning = "", error = "" },
        show_on_dirs = true
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
})

nnoremap("<leader><leader>", ":NvimTreeToggle<CR>", silent)
