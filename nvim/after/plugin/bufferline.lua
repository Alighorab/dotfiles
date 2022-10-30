--[[ local bufferline = require("bufferline")
local signs = { Error = " ✘ ", Warn = " ▲ ", Hint = " ⚑ ", Info = "  " }
local colors = { Error = "#EC5241", Warn = "#EFB839", Hint = "#A3BA5E", Info = "#7EA9A7" }

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
                    table.insert(result, {text = signs.Error.. error, fg = colors.Error })
                end

                if warning ~= 0 then
                    table.insert(result, {text = signs.Warn.. warning, fg = colors.Warn })
                end

                if hint ~= 0 then
                    table.insert(result, {text = signs.Hint.. hint, fg = colors.Hint })
                end

                if info ~= 0 then
                    table.insert(result, {text = signs.Info.. info, fg = colors.Info })
                end
                return result
            end,
        }
    }
}) ]]
