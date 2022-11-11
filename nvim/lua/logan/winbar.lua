local M = {}

local function buf_is_attached(buffer)
	local current_buf = vim.api.nvim_get_current_buf()
	if current_buf == buffer then
		return true
	end
	return false
end

local function construct_winbar(buffers)
    local results = ""
    for _, buffer in ipairs(buffers) do
		if vim.fn.buflisted(buffer) == 1 then
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":~:.")
			local ext = vim.fn.fnamemodify(filename, ":e")
			local icon, color = require("nvim-web-devicons").get_icon(filename, ext, {})
            local bufinfo = vim.fn.getbufinfo(buffer)[1]
			local winbar_object
			if icon and color then
				winbar_object = " %#" .. color .. "#" .. icon .. " "
			else
				winbar_object = ""
			end
			if buf_is_attached(buffer) then
				winbar_object = winbar_object .. "%*" .. filename .. "%m "
			else
                if bufinfo.changed == 1 then
                    winbar_object = winbar_object .. "%#LineNr#" .. filename .. '[+]' .. "%* "
                else
                    winbar_object = winbar_object .. "%#LineNr#" .. filename .. "%* "
                end
			end
			results = results .. winbar_object
		end
	end
    return results
end

function M.find_buffers()
	local buffers = vim.api.nvim_list_bufs()
	local ft = vim.bo.filetype

    -- Ignore help, NvimTree, and non-type windows
	if ft == "help" or ft == "NvimTree" or ft == "" then
		return nil
	end
    -- Ignore floating windows
	if vim.api.nvim_win_get_config(0).relative ~= "" then
		return nil
	end

    return construct_winbar(buffers)
end

return M
