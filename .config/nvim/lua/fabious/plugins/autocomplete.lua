return {
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback_to_mappings' },
        ['<S-Tab>'] = { 'select_prev', 'fallback_to_mappings' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        accept = { auto_bracket = false },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    enabled = false,
    build = 'make install_jsregexp',
    dependencies = {
      'honza/vim-snippets',
      config = function()
        require('luasnip.loaders.from_snipmate').lazy_load()
      end,
    },
    -- dependencies = {
    --   'rafamadriz/friendly-snippets',
    --   config = function()
    --     require('luasnip.loaders.from_vscode').lazy_load()
    --   end,
    -- },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    keys = {
      {
        '<tab>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true,
        silent = true,
        mode = 'i',
      },
      {
        '<tab>',
        function()
          require('luasnip').jump(1)
        end,
        mode = 's',
      },
      {
        '<s-tab>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
      },
    },
  },
}
