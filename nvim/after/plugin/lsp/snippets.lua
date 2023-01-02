-- Snippets
require("luasnip.loaders.from_vscode").lazy_load({
  paths = {
    vim.env.HOME .. "/.local/share/nvim/lazy/friendly-snippets/",
  },
  include = nil, -- Load all languages
  exclude = {},
})
