-- Gruvbox
vim.g.gruvbox_termcolors = 256
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = 0

-- Gruvbox material
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_diagnostic_text_highlight = 0
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1

-- Set colorscheme
vim.cmd("colorscheme gruvbox-material")

-- Make the window transparent
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight clear SignColumn")
