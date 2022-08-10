local Remap = require('fabious.helpers.keybind')
local nmap = Remap.nmap
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

local silent = { silent = true }

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', silent)

-- Remap for dealing with word wrap
nnoremap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nnoremap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ My Keymaps ]]
-- best keymaps
-- vim.keymap.set('i', 'jk', '<ESC>',silent)
inoremap('jk', '<ESC>')
nmap(';', ':')
nmap('Q', '<nop>')
nnoremap('<leader>1', ':e ~/.config/nvim/lua/fabious/init.lua<CR>', { desc = 'Open confing' })
nnoremap('<leader>2', ':e ~/.config/nvim/lua/fabious/keymaps.lua<CR>', { desc = 'Open keymaps'})
nnoremap('<leader>4', ':e ~/.config/nvim/lua/fabious/packer.lua<CR>', { desc = 'Open plugins'})
nnoremap('<leader>5', ':PackerSync<CR>', { desc = 'reload Packer'})

nnoremap('<leader>w', ':w<CR>', silent)
nnoremap('<leader>q', ':q<CR>', silent)
nnoremap('<leader>o', ':only<CR>', silent)

nnoremap('<C-h>', '<C-w>h', silent)
nnoremap('<C-j>', '<C-w>j', silent)
nnoremap('<C-k>', '<C-w>k', silent)
nnoremap('<C-l>', '<C-w>l', silent)

nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")

xnoremap("<leader>p", "\"_dP", silent)
nnoremap("<leader>d", "\"_d", silent)
vnoremap("<leader>d", "\"_d", silent)
nnoremap("<leader>y", "\"+y", silent)
vnoremap("<leader>y", "\"+y", silent)
nnoremap("<leader>Y", "\"+Y", silent)

-- tabs
nnoremap("<leader>ta", ":$tabnew<CR>", silent)
nnoremap("<leader>tc", ":tabclose<CR>", silent)
nnoremap("<leader>to", ":tabonly<CR>", silent)
nnoremap("<leader>tn", ":tabn<CR>", silent)
nnoremap("<leader>tp", ":tabp<CR>", silent)
-- move current tab to previous position
nnoremap("<leader>tmp", ":-tabmove<CR>", silent)
-- move current tab to next position
nnoremap("<leader>tmn", ":+tabmove<CR>", silent)

-- Diagnostic keymaps
nnoremap('[d', vim.diagnostic.goto_prev)
nnoremap(']d', vim.diagnostic.goto_next)
nnoremap('<leader>vf', vim.diagnostic.open_float)
nnoremap('<leader>vl', vim.diagnostic.setloclist)
