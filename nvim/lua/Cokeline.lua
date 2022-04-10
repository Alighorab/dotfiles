-- Cokeline
local get_hex = require('cokeline/utils').get_hex
require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
                if buffer.is_focused then
                    return "#3c3836"
                else 
                    return "Normal"
                end
            end,
        bg = function(buffer)
                if buffer.is_focused then
                    return "#a89984"
                else 
                    return "#3c3836"
                end
            end,
    },
    components = {
        { text = '', bg = get_hex('Normal', 'bg'), },
        { text = ' ', },
        { 
          text = function(buffer) return buffer.filename end,
          style = function(buffer)
            return buffer.is_focused and 'bold' or nil
          end,
        },
        { text = ' ', delete_buffer_on_left_click = false, },
    },
})
