local function getcwd()
	return "%=" .. vim.fn.getcwd()
end

local extention = {
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { getcwd },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	filetypes = {
		"NvimTree",
		"TelescopePrompt",
	},
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nightfox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_c = {},
	},
	extensions = {
		"nvim-dap-ui",
		extention,
	},
})
