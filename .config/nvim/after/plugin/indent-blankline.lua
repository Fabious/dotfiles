require('indent_blankline').setup({
  buftype_exclude = { 'terminal' },
  char = '▏',
  filetype_exclude = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt', 'alpha' },
  show_current_context = true,
  space_char_blankline = ' ',
  use_treesitter = true,
})
