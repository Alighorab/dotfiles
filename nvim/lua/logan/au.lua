local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local ClangFormat = augroup("ClangFormat", {})
local Yank = augroup("HighlightYank", {})
local Help = augroup("HelpGroup", {})

autocmd("TextYankPost", {
	group = Yank,
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

autocmd({ "FileType help" }, {
    group = Help,
    callback = function ()
        vim.cmd("vertical resize 82")
    end,
})
