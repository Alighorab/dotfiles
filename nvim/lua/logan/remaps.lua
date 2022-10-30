local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local onoremap = Remap.onoremap
local nmap = Remap.nmap

local silent = {silent = true}

nnoremap('<Tab>', '<C-6>', silent)
nnoremap('<leader>bd', '<cmd>bd!<cr>', silent)

nnoremap('Y', 'yg$')
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
-- Jump and center
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

--[[ 
The best remaps ever!
  Move lines very quickly
  :[range]move {address}
    Move the lines given by [range] to below the line
    given by {address}. 
]]
vnoremap('J', ':m \'>+1<CR>gv=gv')
vnoremap('K', ':m \'<-2<CR>gv=gv')
nnoremap('<leader>j', ':m .+1<CR>==')
nnoremap('<leader>k', ':m .-2<CR>==')

-- Line text object
xnoremap('il', 'g_o^')
onoremap('il', ':normal vil<cr>')

-- Reselct pasted text
nnoremap('gp', '`[v`]')

-- Copying and pasting from clipboard
nnoremap('<leader>p', '"+p')
nnoremap('<leader>y', '"+y')
vnoremap('<leader>y', '"+y')
nmap('<leader>Y', '"+Y')

-- Terminal mode
vim.cmd('tnoremap <esc> <C-\\><C-n>')
