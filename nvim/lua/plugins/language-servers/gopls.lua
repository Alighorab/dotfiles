local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("logan.utils.lsp").capabilities
  local lsp_flags = require("logan.utils.lsp").lsp_flags
  local on_attach = require("logan.utils.lsp").on_attach

  lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
      on_attach(client, bufnr)
    end,
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
end

return M
