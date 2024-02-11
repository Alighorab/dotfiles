vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { noremap = true, silent = true })
--[[
Change a the word under the cursor and then hit `dot`
to apply the change to the next/previous line
]]
vim.keymap.set("n", "<leader>cn", "*``cgn")
vim.keymap.set("n", "<leader>cN", "#``cgN")

vim.keymap.set("n", "Y", "yg$", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
-- Junp only five lines
vim.keymap.set("n", "<C-d>", "5<C-d>", { noremap = true })
vim.keymap.set("n", "<C-u>", "5<C-u>", { noremap = true })

vim.keymap.set("n", "<leader>n", vim.cmd.enew, { noremap = true })

-- Reselct pasted text
vim.keymap.set("n", "gp", "`[v`]", { noremap = true })

--[[
The best remaps ever!
  Move lines very quickly
  :[range]move {address}
    Move the lines given by [range] to below the line
    given by {address}.
]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==", { noremap = true })

-- Text objects
vim.keymap.set("x", "il", "g_o^", { noremap = true })
vim.keymap.set("o", "il", ":normal vil<cr>", { noremap = true })
vim.keymap.set("o", "ie", ":<C-u>normal! ggVG<CR>", { noremap = true })
vim.keymap.set("x", "ie", ":<C-u>normal! ggVG<CR>", { noremap = true })

-- Copying and pasting from clipboard
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>Y", '"+yg$')

-- Resize split horizontally
vim.keymap.set("n", "+", function()
  vim.cmd("vertical resize +2")
end)
vim.keymap.set("n", "-", function()
  vim.cmd("vertical resize -2")
end)

-- Quickfix list
vim.keymap.set("n", "<leader>qq", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { noremap = true })
vim.keymap.set("n", "<leader>qn", function()
  if not pcall(vim.cmd.cnext) then
    print("QuickFix: No Next Element")
  else
    vim.cmd.normal("zz")
  end
end, { noremap = true })
vim.keymap.set("n", "<leader>qp", function()
  if not pcall(vim.cmd.cprevious) then
    print("QuickFix: No Previous Element")
  else
    vim.cmd.normal("zz")
  end
end, { noremap = true })
vim.keymap.set("n", "<leader>qo", vim.cmd.copen, { noremap = true })
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickFix", {}),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "zf", ":Telescope quickfix<CR>", { buffer = true })
  end,
})
