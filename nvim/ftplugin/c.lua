vim.keymap.set("n", "<leader>gh", vim.cmd.ClangdSwitchSourceHeader, {
  silent = true,
  buffer = true,
  desc = "Clang Switch Source Header",
})
