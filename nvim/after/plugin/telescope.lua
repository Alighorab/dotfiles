local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end
    }):sync()
end

require("telescope").setup {
    defaults = {
        buffer_previewer_maker = new_maker,
    },
}

nnoremap("gff", function()
    require('telescope.builtin').find_files()
end)

nnoremap("gfg", function()
    require('telescope.builtin').live_grep()
end)

nnoremap("gfb", function()
    require('telescope.builtin').buffers()
end)

nnoremap("gfh", function()
    require('telescope.builtin').help_tags()
end)

nnoremap("gft", function()
    require('telescope.builtin').treesitter()
end)

nnoremap("gfz", function()
    require('telescope.builtin').current_buffer_fuzzy_find()
end)

nnoremap("gfk", function()
    require('telescope.builtin').keymaps()
end)
