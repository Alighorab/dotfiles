local api = require("nvim-tree.api")

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  auto_reload_on_write = true,
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
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
        { key = "<Tab>", action = "preview" },
        { key = "cd", action = "cd" },
        { key = "a", action = "create" },
        { key = "y", action = "copy" },
        { key = "d", action = "cut" },
        { key = "p", action = "paste" },
        { key = "r", action = "rename" },
        { key = "D", action = "remove" },
        { key = "E", action = "expand_all" },
        { key = "W", action = "collapse_all" },
        { key = "zh", action = "toggle_dotfiles" },
        { key = "I", action = "toggle_git_ignored" },
      },
    },
  },
  renderer = {
    group_empty = true,
    root_folder_modifier = ":~",
    highlight_opened_files = "all",
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
})

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
