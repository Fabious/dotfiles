-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ My Keymaps ]]
-- best keymaps
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('n' , ';', ':')
vim.keymap.set('n' , 'Q', '<nop>')
vim.keymap.set('n', '<leader>1', ':e ~/.config/nvim/lua/fabious/init.lua<CR>', { silent = true })
vim.keymap.set('n', '<leader>2', ':source ~/.config/nvim/init.lua<CR>', { silent = true })
vim.keymap.set('n', '<leader>4', ':e ~/.config/nvim/lua/fabious/packer.lua<CR>', { silent = true })
vim.keymap.set('n', '<leader>5', ':PackerSync<CR>', { silent = true })

vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', ':only<CR>', { silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

vim.keymap.set("x", "<leader>p", "\"_dP", { silent = true })
vim.keymap.set("n", "<leader>d", "\"_d", { silent = true })
vim.keymap.set("v", "<leader>d", "\"_d", { silent = true })
vim.keymap.set("n", "<leader>y", "\"+y", { silent = true })
vim.keymap.set("v", "<leader>y", "\"+y", { silent = true })
vim.keymap.set("n", "<leader>Y", "\"+Y", { silent = true })

-- tabs
vim.keymap.set("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.keymap.set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
vim.keymap.set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>vf', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>vl', vim.diagnostic.setloclist)

