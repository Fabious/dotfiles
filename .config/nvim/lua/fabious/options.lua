-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.backup = false
vim.o.breakindent = true
vim.o.cmdheight = 1
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.mouse = 'a'
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.undofile = false
vim.o.updatetime = 100
vim.wo.number = true
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.everforest_background = 'hard'
vim.cmd [[colorscheme terafox]]

-- Prettier configuration
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_require_pragma"] = 0
vim.g["prettier#exec_cmd_async"] = 1

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

