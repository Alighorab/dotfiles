-- Snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = {
        vim.env.HOME .. "/.local/share/nvim/site/pack/packer/start/friendly-snippets/"
    },
	include = nil, -- Load all languages
	exclude = {},
})
