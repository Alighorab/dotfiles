local augroup = vim.api.nvim_create_augroup
local ClangFormat = augroup("ClangFormat", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Set clang-format config filetype
autocmd({ "BufReadPost" }, {
	group = ClangFormat,
	pattern = ".clang-format",
	callback = function()
		vim.opt.filetype = "yaml"
	end,
})
