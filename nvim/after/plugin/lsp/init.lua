local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local open_float_opts = {
    border = "single",
    source = "always", -- Or "if_many"
    severity_sort = true,
    scope = "cursor",
    focusable = true,
    focus = false,
    close_events = {
        "CursorMoved",
        "CursorMovedI",
        "InsertEnter",
        "DiagnosticChanged"
    },
    prefix = function(diagnostic, _, _)
        local signs = {
            [vim.diagnostic.severity.ERROR] = function() return " " end,
            [vim.diagnostic.severity.WARN] = function() return " " end,
            [vim.diagnostic.severity.HINT] = function() return "ﴞ " end,
            [vim.diagnostic.severity.INFO] = function() return " " end
        }
        local colors = {
            [vim.diagnostic.severity.ERROR] = function() return "DiagnosticFloatingError" end,
            [vim.diagnostic.severity.WARN] = function() return "DiagnosticFloatingWarn" end,
            [vim.diagnostic.severity.HINT] = function() return "DiagnosticFloatingHint" end,
            [vim.diagnostic.severity.INFO] = function() return "DiagnosticFloatingInfo" end
        }
        return signs[diagnostic.severity](), colors[diagnostic.severity]()
    end,
    format = function(diagnostic)
        local WIN_WIDTH = vim.fn.winwidth(0)
        local max_width = math.floor(WIN_WIDTH * 0.7)
        local wrap_msg = require("logan.utils.wrap").wrap_text(diagnostic.message, max_width)
        local msg = table.concat(wrap_msg, "\n")
        return msg
    end,
}

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gh", function()
		vim.cmd("Lspsaga lsp_finder")
	end, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gD", function()
		vim.cmd("TSTextobjectPeekDefinitionCode @function.outer")
	end, bufopts)
	vim.keymap.set("n", "K", function()
		vim.cmd("Lspsaga hover_doc")
	end, bufopts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.cmd("Lspsaga rename")
	end, bufopts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", function()
		vim.cmd("Lspsaga code_action")
	end, bufopts)
	vim.keymap.set("n", "<leader>tr", function()
		vim.cmd("Trouble")
	end, bufopts)

	vim.api.nvim_create_autocmd({ "CursorHold", "DiagnosticChanged" }, {
		buffer = bufnr,
		callback = function()
            vim.diagnostic.open_float(open_float_opts)
		end,
	})
end

local lsp_flags = {
	debounce_text_changes = 150,
}

-- Diagnostics config
vim.diagnostic.config({
	virtual_text = false,
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
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- vim.cmd("highlight! FloatBorder guibg=None guifg=DarkYellow")
-- vim.cmd("highlight! NormalFloat guibg=None guifg=None")
vim.cmd("highlight! DiagnosticFloatingError guibg=None guifg=#fb4934")
vim.cmd("highlight! DiagnosticFloatingWarn guibg=None guifg=DarkYellow")
vim.cmd("highlight! DiagnosticFloatingInfo guibg=None guifg=LightBlue")
vim.cmd("highlight! DiagnosticFloatingHint guibg=None guifg=LightGrey")
