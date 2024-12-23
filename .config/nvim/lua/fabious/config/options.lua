-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.backup = false
vim.o.breakindent = true
vim.o.cmdheight = 1
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'indent'
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.scrolloff = 8
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.undofile = false
vim.o.updatetime = 100
vim.wo.number = true
vim.wo.signcolumn = 'yes'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.everforest_background = 'hard'
vim.g.nord_italic = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- :make to populate quickfix with ESLint
vim.o.errorformat = '%f:%l:%c: %m [%t%*[^]]]' -- parse eslint errors
vim.o.makeprg = "npx eslint -f unix 'src/**/*.{js,ts,jsx,tsx}'" -- make command
