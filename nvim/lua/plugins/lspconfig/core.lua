return function(_, _)
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local on_attach = require("logan.utils.lsp").on_attach

  -- Diagnostics Configurations
  vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
  })

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
    "bashls",
  }

  local default_config = {
    on_attach = function(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    flags = lsp_flags,
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(default_config)
  end

  require("lspconfig").pylsp.setup({
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 88,
          },
        },
      },
    },
  })

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

  require("lspconfig").rust_analyzer.setup({
    vim.tbl_extend("force", default_config, {
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

  require("lspconfig").lua_ls.setup(vim.tbl_extend("force", default_config, {
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
end
