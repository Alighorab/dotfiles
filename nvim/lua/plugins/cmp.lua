return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()
          -- If you want insert `(` after select function or method item
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      {
        "quangnguyen30192/cmp-nvim-ultisnips",
        config = function()
          require("cmp_nvim_ultisnips").setup({
            filetype_source = "treesitter",
            show_snippets = "all",
            documentation = function(snippet)
              return snippet.description
            end,
          })
        end,
        dependencies = {
          {
            "SirVer/ultisnips",
            config = function()
              vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath("config") .. "/ultisnips" }
            end,
          },
        },
      },
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      require("logan.utils.kinds").setup()

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      return {
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              ultisnips = "[Snip]",
              path = "[Path]",
            },
          }),
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
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
          ["<C-u>"] = cmp.mapping.scroll_docs(-2),
          ["<C-d>"] = cmp.mapping.scroll_docs(2),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "ultisnips" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "neorg" },
        }),
      }
    end,
  },
}
