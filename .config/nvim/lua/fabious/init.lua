require('fabious.keymaps')
require('fabious.options')
require('fabious.packer')
require('fabious.treesitter')
require('fabious.telescope')
require('fabious.comment')
require('fabious.feline')
require('fabious.tabby')
require('fabious.lsp')
require('fabious.toggleterm')
require('fabious.indent-blankline')
require('fabious.gitsigns')

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

