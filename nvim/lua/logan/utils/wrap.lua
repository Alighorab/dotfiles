-- This file is copied from lspsaga.nvim
local wrap = {}
local space = " "

-- If the content too long.
-- auto wrap according width
-- fill the space with wrap text
function wrap.wrap_text(text, width)
	local ret = {}

	if #text <= width then
		table.insert(ret, text)
		return ret
	end

	local tbl = vim.tbl_filter(function(a)
		return #a ~= 0
	end, vim.split(text, "%s"))

	if #tbl == 1 then
		if tbl[1]:find("──") then
			table.insert(ret, wrap.generate_spe_line(width))
			return ret
		end
	end

	local start_index, length = 1, 1

	for i = 1, #tbl do
		length = length + #tbl[i] + 1
		if length == width then
			table.insert(ret, table.concat(tbl, space, start_index, i))
			start_index = i + 1
			length = 0
		end

		if length > width and length - #tbl[i] <= width then
			table.insert(ret, table.concat(tbl, space, start_index, i - 1))
			start_index = i
			length = 0
		end

		if length < width and i == #tbl then
			table.insert(ret, table.concat(tbl, space, start_index, i))
		end
	end

	return ret
end

function wrap.generate_spe_line(width)
	local char = "─"
	local line = ""
	for _ = 1, width, 1 do
		line = line .. char
	end
	return line
end

return wrap
