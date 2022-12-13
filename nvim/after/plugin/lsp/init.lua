local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Diagnostics Configurations
vim.diagnostic.config({
	virtual_text = false,
})

local open_float_opts = {
    border = "single",
    source = "always",
    severity_sort = true,
    scope = "line",
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gh", function()
        require("lspsaga.finder"):lsp_finder()
	end, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", function()
        require("lspsaga.hover"):render_hover_doc()
	end, bufopts)
	vim.keymap.set("n", "grn", function()
        require("lspsaga.rename"):lsp_rename()
	end, bufopts)
	vim.keymap.set({ "n", "v" }, "gca", function()
        require("lspsaga.codeaction"):code_action()
	end, bufopts)
	vim.keymap.set("n", "gtr", function()
        require("trouble"):open()
	end, bufopts)

    -- Diagnostics
    local group = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })
	vim.api.nvim_create_autocmd({ "CursorHold", "DiagnosticChanged" }, {
		buffer = bufnr,
        group = group,
		callback = function()
			if vim.api.nvim_get_mode().mode == "n" then
				vim.diagnostic.open_float(open_float_opts)
			end
		end,
	})
end

local lsp_flags = {
	debounce_text_changes = 150,
}

-- Signs
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- Servers
local lspconfig = require("lspconfig")

local servers = {
	"clangd",
	"vimls",
	"pyright",
	"bashls",
	"html",
	"jsonls",
	"yamlls",
}

-- Mason
local ensure_installed = vim.tbl_flatten(servers)
local additional_servers = {
    "gopls",
    "rust_analyzer",
    "sumneko_lua",
}
for _, server in ipairs(additional_servers) do
    table.insert(ensure_installed, server)
end

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
})

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

-- Colors
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "None", fg = "#fb4934" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "None", fg = "LightBlue" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "None", fg = "DarkYellow" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "None", fg = "LightGrey" })
--[[
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "DarkYellow" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", fg = "None" })
]]
