require('fabious.keymaps')
require('fabious.options')
require('fabious.packer')
require('fabious.treesitter')
require('fabious.telescope')
require('fabious.comment')
require('fabious.feline')
require('fabious.tabby')
require('fabious.lsp')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable toggleterm.nvim
require("toggleterm").setup {
  direction = 'vertical',
  open_mapping = [[<c-t>]],
  size = vim.o.columns * 0.4
}

-- Enable File explorer
require("nvim-tree").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_current_context = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

