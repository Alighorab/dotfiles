local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gD", "<cmd>TSTextobjectPeekDefinitionCode @function.outer<CR>", bufopts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float()
		end,
	})
end

local lsp_flags = {
	debounce_text_changes = 150,
}

-- Diagnostics config
vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = "always", -- Or "if_many"
		severity_sort = true,
        scope = "cursor"
	},
})

local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Servers --

local lspconfig = require("lspconfig")

local servers = {
	"clangd",
	"vimls",
	"pyright",
	"bashls",
	"html",
	"jsonls",
	"yamlls",
	"prosemd_lsp",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = lsp_flags,
	})
end

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

require("rust-tools").setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = lsp_flags,
		settings = {
			["rust-analyzer"] = {
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
			},
		},
	},
})

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
