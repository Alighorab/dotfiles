local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr)
  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set(
    "n",
    "<leader>gr",
    vim.lsp.buf.references,
    vim.tbl_extend("force", bufopts, { desc = "Lsp References" })
  )
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Lsp Definition" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "Lsp Declaration" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Lsp Hover" }))
  vim.keymap.set("n", "<C-k>", vim.cmd.Man, vim.tbl_extend("force", bufopts, { desc = "Open manpage for cword" }))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Lsp Rename" }))
  vim.keymap.set({ "n", "v" }, "<leader>ca", function()
    vim.lsp.buf.code_action({
      apply = true,
    })
  end, vim.tbl_extend("force", bufopts, { desc = "Lsp CodeAction" }))
  vim.keymap.set(
    "n",
    "<leader>dn",
    vim.diagnostic.goto_next,
    vim.tbl_extend("force", bufopts, { desc = "Goto next diagnostic" })
  )
  vim.keymap.set(
    "n",
    "<leader>dp",
    vim.diagnostic.goto_prev,
    vim.tbl_extend("force", bufopts, { desc = "Goto previous diagnostic" })
  )
  vim.keymap.set(
    "n",
    "<leader>dq",
    vim.diagnostic.setqflist,
    vim.tbl_extend("force", bufopts, { desc = "Add all diagnostics to the quickfix list" })
  )

  local range_formatting = function()
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    vim.lsp.buf.format({
      range = {
        ["start"] = { start_row, 0 },
        ["end"] = { end_row, 0 },
      },
      async = true,
    })
  end

  vim.keymap.set(
    "n",
    "<leader>f",
    vim.lsp.buf.format,
    vim.tbl_extend("force", bufopts, { desc = "Format current buffer" })
  )
  vim.keymap.set("v", "<leader>f", range_formatting, vim.tbl_extend("force", bufopts, { desc = "Range formatting" }))

  -- NavBuddy
  vim.keymap.set(
    "n",
    "<leader>nv",
    require("nvim-navbuddy").open,
    vim.tbl_extend("force", bufopts, { desc = "NavBuddy" })
  )

  vim.keymap.set("n", "<leader>dl", function()
    vim.diagnostic.open_float(require("logan.utils.diagnostics").float_opts)
  end, vim.tbl_extend("force", bufopts, { desc = "Open diagnostics for current line" }))
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
M.lsp_flags = { debounce_text_changes = 150 }

return M
