-- Gruvbox material
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_diagnostic_text_highlight = 0
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.opt.background = "dark"

-- tokyonight
require("tokyonight").setup({
    transparent = true,
    styles = {
        sidebars = "transparent",
    }
})

-- Set colorscheme
vim.cmd.colorscheme("tokyonight-moon")
vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#E1D9D1" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { bg = "None" })
