require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'nightfox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {},
        lualine_x = {'filetype'},
        lualine_y = {'progress', 'location'},
        lualine_z = {"os.date('%I:%M %p')", 'data', "require'lsp-status'.status()"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {}
}
