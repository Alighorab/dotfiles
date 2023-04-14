local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
require("logan.utils.kinds").setup()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
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
    ["<C-u>"] = cmp.mapping.scroll_docs(-2),
    ["<C-d>"] = cmp.mapping.scroll_docs(2),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ["<C-j>"] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "ultisnips" },
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
  }),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.api.nvim_set_hl(0, "CmpItemMenu", { bg = "None", fg = "#808080" })
