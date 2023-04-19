return {
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  "HiPhish/nvim-ts-rainbow2",
  {
    "danymat/neogen",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "rust",
        "help",
        "vim",
        "lua",
        "python",
        "bash",
        "markdown",
        "markdown_inline",
        "make",
        "diff",
        "json",
        "gitcommit",
        "git_rebase",
        "gitattributes",
        "gitignore",
        "sxhkdrc",
        "toml",
        "html",
        "javascript",
        "typescript",
        "sql",
        "verilog",
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
            ["io"] = "@loop.inner",
            ["ao"] = "@loop.outer",
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
      matchup = {
        enable = false, -- mandatory, false will disable the whole extension
        disable = {}, -- optional, list of language that will be disabled
      },
      rainbow = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
