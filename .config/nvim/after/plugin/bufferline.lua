-- :h bufferline-configuration
require('bufferline').setup {
  options = {
    mode = 'buffers',
    numbers = 'ordinal',
    diagnostics = 'nvim_lsp',
    separator_style = 'slant',
  },
}
