-- luacheck: no max line length
local map = function(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Suspend (aka go to terminal)
map('n', '<C-t>', ':stop<CR>', { noremap = false })

-- Turn off last search highlight
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
map('n', '<leader>ba', '<cmd>%bd|e#<CR>')
map('n', '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>')
map('n', '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>')
map('n', '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>')
map('n', '<C-1>', '<cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<C-2>', '<cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<C-3>', '<cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<C-4>', '<cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<C-5>', '<cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<C-6>', '<cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<C-7>', '<cmd>BufferLineGoToBuffer 7<CR>')
map('n', '<C-8>', '<cmd>BufferLineGoToBuffer 8<CR>')
map('n', '<C-9>', '<cmd>BufferLineGoToBuffer 9<CR>')

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

-- File Browser
vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })
map('n', '<leader>e', ':RnvimrToggle<CR>')
vim.g.rnvimr_enable_picker = 1

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
-- map('n', '<leader>vf', vim.diagnostic.open_float)
map('n', '<leader>cl', vim.diagnostic.setloclist)

-- Git
map('n', '<leader>gY', '<cmd>lua require"gitlinker".get_repo_url()<cr>')
map(
  'n',
  '<leader>gb',
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)
map(
  'v',
  '<leader>gb',
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)
map(
  'n',
  '<leader>gB',
  '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)
map('n', ']g', '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
map('n', '[g', '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })
