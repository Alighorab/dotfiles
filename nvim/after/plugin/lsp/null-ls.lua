local formatters = {
	"clang_format",
	"stylua",
	"shfmt",
	"rustfmt",
	"black",
	"gofumpt",
	"prettier",
}

require("mason-null-ls").setup({
	ensure_installed = formatters,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt.with({
			extra_args = { "-ci" },
		}),
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.prettier,
	},
})

local Reamp = require("logan.utils.keymap")
local nnoremap = Reamp.nnoremap
local vnoremap = Reamp.vnoremap

local range_formatting = function()
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	vim.lsp.buf.format({
		range = {
			["start"] = { start_row, 0 },
			["end"] = { end_row, 0 },
		},
	})
end

nnoremap("<leader>f", vim.lsp.buf.format)
vnoremap("<leader>f", range_formatting)
