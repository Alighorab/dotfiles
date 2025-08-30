local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("logan.utils.lsp").capabilities
  local lsp_flags = require("logan.utils.lsp").lsp_flags
  local on_attach = require("logan.utils.lsp").on_attach

  lspconfig.marksman.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      marksman = {
        -- Disable specific diagnostic features
        completion = {
          -- Reduce wiki link suggestions if not using wiki-style links
          wiki = false,
        },
      },
    },
  })
end

return M
