-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",                                                      -- Collection of configurations for built-in LSP client
  }

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'                                           -- Highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- Additional textobjects for treesitter

  use 'wbthomason/packer.nvim'                                                    -- Package manager
  use 'tpope/vim-fugitive'                                                        -- Fugitive
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use "kylechui/nvim-surround"                                                    -- Surround
  use 'tpope/vim-sleuth'                                                          -- Detect tabstop and shiftwidth automatically
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups
  use 'numToStr/Comment.nvim'                                                     -- Comment
  use 'JoosepAlviste/nvim-ts-context-commentstring'                               -- Enable JSX comment
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }               -- Autocompletion
  use 'feline-nvim/feline.nvim'
  use "nanozuki/tabby.nvim"
  use 'lukas-reineke/indent-blankline.nvim'                                       -- Add indentation guides even on blank lines
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
  use { "windwp/nvim-autopairs" }                                                 -- Autopairs
  use { "akinsho/toggleterm.nvim", tag = 'v2.*' }                                 -- Toggleterm
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } } -- File explorer
  use { "prettier/vim-prettier" }                                                 -- Prettier
  use  "folke/which-key.nvim"

  -- SNIPPETS
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- Snippet Engine and Snippet Expansion
  use "rafamadriz/friendly-snippets"

  -- THEMES
  use "EdenEast/nightfox.nvim"
  use 'ellisonleao/gruvbox.nvim'
  use 'overcache/NeoSolarized'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

