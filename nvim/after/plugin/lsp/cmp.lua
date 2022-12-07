local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
require("logan.utils.kinds").setup()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	formatting = {
		format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[Buf]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                path = "[Path]",
            }
        },
	},
	enabled = function()
        -- Disable in telescope prompt
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end
		return true
	end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
        completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-j>"] = cmp.mapping(function(_)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(_)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "path" },
	}),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Colors
vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
vim.cmd("highlight! CmpItemMenu guibg=NONE guifg=#808080")
vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
vim.cmd("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
vim.cmd("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
vim.cmd("highlight! link CmpItemKindInterface CmpItemKindVariable")
vim.cmd("highlight! link CmpItemKindText CmpItemKindVariable")
vim.cmd("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
vim.cmd("highlight! link CmpItemKindMethod CmpItemKindFunction")
vim.cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
vim.cmd("highlight! link CmpItemKindProperty CmpItemKindKeyword")
vim.cmd("highlight! link CmpItemKindUnit CmpItemKindKeyword")
