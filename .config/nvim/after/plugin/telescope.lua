local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local map = function(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-h>'] = 'which_key',
      },
    },
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
    layout_config = {
      height = 30,
    },
    border = true,
    borderchars = {
      prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
    },
  },

  pickers = {
    find_files = { previewer = false },
    git_files = { previewer = false },
    live_grep = { previewer = false },
    oldfiles = { previewer = false },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')

-- Keymaps
-- See `:help telescope.builtin`
map('n', '<leader>h', builtin.oldfiles, { desc = 'Files [H]istory' })
map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy finder' })
map('n', '<C-g>', builtin.live_grep, { desc = 'Live [G]rep' })
map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
map('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
