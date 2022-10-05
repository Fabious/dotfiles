local map = function(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- [[ My Keymaps ]]
-- best keymaps
map('i', 'jk', '<ESC>')
map('n', ';', ':', { noremap = false })
map('n', 'Q', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', '<C-s>', '<cmd>w<CR>')

-- a tester
map('n', '<CR>', '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })

map('n', '<leader>1', ':e ~/.config/nvim/lua/fabious<CR>', { desc = 'Open config' })
map('n', '<leader>2', ':e ~/.config/nvim/lua/fabious/keymaps.lua<CR>', { desc = 'Open keymaps' })
map('n', '<leader>3', ':e ~/.config/nvim/after/plugin<CR>', { desc = 'Open plugins config' })
map('n', '<leader>4', ':e ~/.config/nvim/lua/fabious/packer.lua<CR>', { desc = 'Open plugins' })
map('n', '<leader>5', ':PackerSync<CR>', { desc = 'reload Packer' })

map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>o', ':only<CR>')

-- Window
map('n', '<C-h>', '<cmd>wincmd h<CR>')
map('n', '<C-j>', '<cmd>wincmd j<CR>')
map('n', '<C-k>', '<cmd>wincmd k<CR>')
map('n', '<C-l>', '<cmd>wincmd l<CR>')
map('n', '<Up>', '<cmd>wincmd -<CR>')
map('n', '<Down>', '<cmd>wincmd +<CR>')
map('n', '<Left>', '<cmd>wincmd <<CR>')
map('n', '<Right>', '<cmd>wincmd ><CR>')
map('n', '<leader>=', '<cmd>wincmd =<CR>')

-- Buffers
map('n', '<Tab>', '<cmd>bn<CR>')
map('n', '<S-Tab>', '<cmd>bp<CR>')
map('n', '<leader>bd', '<cmd>bd<CR>')

-- Copypasta
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('x', '<leader>p', '"_dP')
map('n', '<leader>d', '"_d')
map('v', '<leader>d', '"_d')
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', '"+Y')

-- Tabs
map('n', '<leader>ta', ':$tabnew<CR>')
map('n', '<leader>tc', ':tabclose<CR>')
map('n', '<leader>to', ':tabonly<CR>')
map('n', '<leader>tn', ':tabn<CR>')
map('n', '<leader>tp', ':tabp<CR>')
-- move current tamn', ':+tabmove<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
-- map('n', '<leader>vf', vim.diagnostic.open_float)
map('n', '<leader>cl', vim.diagnostic.setloclist)

-- Tree
map('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<CR>')

-- Git
map('n', '<leader>g', '<cmd>Neogit<CR>')
map('n', ']g', '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
map('n', '[g', '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })

-- Zen mode
map('n', '<leader>z', '<cmd>ZenMode<CR>')
