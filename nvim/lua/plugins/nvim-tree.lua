return {
  "kyazdani42/nvim-tree.lua",
  opts = function()
    local api = require("nvim-tree.api")
    local function on_attach(bufnr)
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
      vim.keymap.set("n", "d", api.fs.cut, opts("Cut"))
      vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
      vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
      vim.keymap.set("n", "zh", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
      vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
    end
    return {
      on_attach = on_attach,
      sort_by = "case_sensitive",
      auto_reload_on_write = true,
      remove_keymaps = true,
      view = {
        adaptive_size = true,
        relativenumber = true,
        number = true,
        float = {
          enable = false,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 60,
            height = 24,
            row = 8,
            col = 60,
          },
        },
      },
      renderer = {
        group_empty = true,
        root_folder_modifier = ":~",
        highlight_opened_files = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "M",
              staged = "M",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "D",
              ignored = "I",
            },
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = { "^.git$" },
      },
      diagnostics = {
        enable = true,
        icons = { hint = "", info = "", warning = "", error = "" },
        show_on_dirs = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
      },
    }
  end,
  config = function(_, opts)
    local api = require("nvim-tree.api")
    require("nvim-tree").setup(opts)
    vim.keymap.set("n", "<leader><leader>", function()
      api.tree.toggle()
      api.tree.reload({}, 0)
    end, { noremap = true, silent = true, desc = "Toggle NvimTree" })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
          return
        end
        vim.cmd.cd(data.file)
        api.tree.open()
      end,
    })
  end,
  enabled = false,
}
