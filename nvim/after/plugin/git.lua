local Remap = require("logan.utils.keymap")
local nnoremap = Remap.nnoremap
-- Git
nnoremap("<leader>gg", vim.cmd.Git)
nnoremap("<leader>gd", function()
  vim.cmd.Git("diff %")
end)
