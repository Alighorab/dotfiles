local formatters = {
  "stylua",
  "shfmt",
  "rustfmt",
  "black",
  "gofumpt",
  "eslint_d",
}

local linters = {
  "flake8",
}

local ensure_installed = vim.tbl_flatten(formatters)
for _, linter in ipairs(linters) do
  table.insert(ensure_installed, linter)
end

require("mason-null-ls").setup({
  ensure_installed = ensure_installed,
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Formatters
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-ci" },
    }),
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.eslint_d,

    -- Linters
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.eslint_d,
  },
})
