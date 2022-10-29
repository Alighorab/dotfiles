require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox-material',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,

                shorting_target = 40,
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = '[+]',      -- Text to show when the file is modified.
                    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            }
        },
        lualine_x = {'filetype'},
        lualine_y = {'progress', 'location'},
        lualine_z = {"os.date('%I:%M %p')", 'data', "require'lsp-status'.status()"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        -- lualine_a = {
        --     {
        --         'buffers',
        --         show_filename_only = true,
        --         show_modified_status = true,
        --         mode = 0,
        --         max_length = vim.o.columns * 2 / 3,
        --         symbols = {
        --             modified = ' ●',      -- Text to show when the buffer is modified
        --             alternate_file = '', -- Text to show to identify the alternate file
        --             directory =  '',     -- Text to show when the buffer is a directory
        --         },
        --     }
        -- },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    extensions = {}
}
