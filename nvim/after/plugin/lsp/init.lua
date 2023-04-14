local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Diagnostics Configurations
vim.diagnostic.config({
  virtual_text = true,
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
    "DiagnosticChanged",
  },
  prefix = function(diagnostic, _, _)
    local signs = {
      [vim.diagnostic.severity.ERROR] = function()
        return " "
      end,
      [vim.diagnostic.severity.WARN] = function()
        return " "
      end,
      [vim.diagnostic.severity.HINT] = function()
        return "ﴞ "
      end,
      [vim.diagnostic.severity.INFO] = function()
        return " "
      end,
    }
    local colors = {
      [vim.diagnostic.severity.ERROR] = function()
        return "DiagnosticFloatingError"
      end,
      [vim.diagnostic.severity.WARN] = function()
        return "DiagnosticFloatingWarn"
      end,
      [vim.diagnostic.severity.HINT] = function()
        return "DiagnosticFloatingHint"
      end,
      [vim.diagnostic.severity.INFO] = function()
        return "DiagnosticFloatingInfo"
      end,
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
  vim.keymap.set("n", "gh", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "Lsp References" }))
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
  vim.keymap.set("n", "<leader>tr", function()
    require("trouble"):open()
  end, vim.tbl_extend("force", bufopts, { desc = "Lsp Diagnostics" }))
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

end

local lsp_flags = {
  debounce_text_changes = 150,
}

-- Signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Servers
local lspconfig = require("lspconfig")

local servers = {
  "clangd",
  "vimls",
  "pylsp",
  "bashls",
  "tsserver",
}
}

local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(default_config)
end

require("lspconfig").gopls.setup({
  vim.tbl_extend("force", default_config, {
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }),
})

require("rust-tools").setup({
  server = vim.tbl_extend("force", default_config, {
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
  }),
})

require("lspconfig").sumneko_lua.setup(vim.tbl_extend("force", default_config, {
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
}))
