local bufferline = require("bufferline")
local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap
local signs = { Error = " ✘ ", Warn = " ▲ ", Hint = " ⚑ ", Info = "  " }

bufferline.setup({
    options = {
        indicator = {
            icon = "┃",
            style = "icon"
        },
---@diagnostic disable-next-line: assign-type-mismatch
        separator_style = {"", ""},
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        truncate_names = false,
        always_show_bufferline = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                text_align = "center",
                highlight = "File",
                separator = true
            },
            {
                filetype = "packer",
                text = "Packer",
                text_align = "center",
                highlight = "File",
                separator = true
            },
            {
                filetype = "help",
                text = "Vim Help",
                text_align = "center",
                highlight = "File",
                separator = true
            },
        },
        custom_areas = {
            right = function()
                local result = {}
                local seve = vim.diagnostic.severity
                local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
                local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
                local info = #vim.diagnostic.get(0, {severity = seve.INFO})
                local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

                if error ~= 0 then
                    table.insert(result, {text = signs.Error.. error, fg = "#EC5241"})
                end

                if warning ~= 0 then
                    table.insert(result, {text = signs.Warn.. warning, fg = "#EFB839"})
                end

                if hint ~= 0 then
                    table.insert(result, {text = signs.Hint.. hint, fg = "#A3BA5E"})
                end

                if info ~= 0 then
                    table.insert(result, {text = signs.Info.. info, fg = "#7EA9A7"})
                end
                return result
            end,
        }
    }
})

nnoremap("gf", bufferline.pick_buffer)
