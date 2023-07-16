return {
  -- Startup plugin
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'b0o/schemastore.nvim',
      'ray-x/lsp_signature.nvim',
      'RRethy/vim-illuminate',
    },
  },
  { 'glepnir/lspsaga.nvim', branch = 'main' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'windwp/nvim-ts-autotag',
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- Autocomplete & Snippets
  { 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp' } },
  { 'L3MON4D3/LuaSnip', dependencies = { 'saadparwaiz1/cmp_luasnip' } },
  'rafamadriz/friendly-snippets',
  'honza/vim-snippets',

  -- Visual enhancements
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  },
  { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },
  'lukas-reineke/indent-blankline.nvim',
  'gen740/SmoothCursor.nvim',

  -- Utils
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },

  -- Git
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'ruifm/gitlinker.nvim',

  -- Project explorer
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1 },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end,
  },
  { 'folke/neodev.nvim', opts = {} },

  -- Themes
  'EdenEast/nightfox.nvim',
  'folke/tokyonight.nvim',
  'sainnhe/everforest',
  'ellisonleao/gruvbox.nvim',
  'B4mbus/oxocarbon-lua.nvim',
}