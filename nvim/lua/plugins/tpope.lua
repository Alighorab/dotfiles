return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gg", vim.cmd.Git, desc = "fugitive" },
    },
    cmd = {
      "Git",
      "Gedit",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "Glgrep",
      "GMove",
      "GDelete",
      "GRename",
      "GRemove",
      "GBrowse",
    },
  },
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Delete",
      "Move",
      "Rename",
      "Copy",
      "Duplicate",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Llocate",
      "Wall",
      "SudoWrite",
      "SudoEdit",
    },
  },
}
