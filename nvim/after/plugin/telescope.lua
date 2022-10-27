local Remap = require("logan.keymap")
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
    }
}


nnoremap("<leader>ff", function()
    require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.8}})
end)

nnoremap("<leader>fg", function()
    require('telescope.builtin').git_files()
end)

nnoremap("<leader>fb", function()
    require('telescope.builtin').buffers({layout_strategy='vertical',layout_config={width=0.8}})
end)

nnoremap("<leader>fh", function()
    require('telescope.builtin').help_tags()
end)

nnoremap("<leader>ft", function()
    require('telescope.builtin').tags({layout_strategy='vertical',layout_config={width=0.8}})
end)

nnoremap("<leader>fs", function()
    require('telescope.builtin').treesitter()
end)

nnoremap("<leader>fz", function()
    require('telescope.builtin').current_buffer_fuzzy_find()
end)

nnoremap("<leader>tk", function()
    require('telescope.builtin').keymaps()
end)

