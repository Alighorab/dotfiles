vim.keymap.set("n", "<Tab>", vim.cmd.bnext, { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { noremap = true, silent = true })

vim.keymap.set("n", "Y", "yg$", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
-- Jump and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

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
vim.keymap.set("n", "<leader>Y", '"+Y')

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
vim.keymap.set("n", "<leader>qn", vim.cmd.cnext, { noremap = true })
vim.keymap.set("n", "<leader>qp", vim.cmd.cprevious, { noremap = true })

-- Terminal mode
-- vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true })
