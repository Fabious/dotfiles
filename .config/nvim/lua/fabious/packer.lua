-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'b0o/schemastore.nvim',
      'ray-x/lsp_signature.nvim',
      'RRethy/vim-illuminate',
    },
  }
  use { 'glepnir/lspsaga.nvim', branch = 'main' }
  use 'simrat39/rust-tools.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'windwp/nvim-ts-autotag'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }
  use 'lukas-reineke/indent-blankline.nvim'

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   config = function()
  --     require('nvim-tree').setup {
  --       view = {
  --         width = '100%',
  --       },
  --       actions = {
  --         open_file = {
  --           quit_on_open = true,
  --         },
  --       },
  --     }
  --   end,
  --   requires = 'kyazdani42/nvim-web-devicons',
  -- }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  use 'ruifm/gitlinker.nvim'
  use {
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  }

  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup()
    end,
  }

  -- Autocomplete
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion
  use 'rafamadriz/friendly-snippets'

  -- THEMES
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'
  use {
    'ellisonleao/gruvbox.nvim',
    -- remove this with neovim 0.8
    commit = 'cb7a8a867cfaa7f0e8ded57eb931da88635e7007',
  }
  use 'B4mbus/oxocarbon-lua.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' },
  }

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
