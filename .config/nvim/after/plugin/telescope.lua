local map = function(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

-- local function telescope_buffer_dir()
--   return vim.fn.expand '%:p:h'
-- end
local fb_actions = require('telescope').extensions.file_browser.actions

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    file_browser = {
      -- cwd = telescope_buffer_dir(),
      grouped = true,
      hidden = true,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      initial_mode = 'normal',
      layout_config = { height = 40 },
      path = '%:p:h',
      previewer = false,
      respect_gitignore = false,
      theme = 'dropdown',
      mappings = {
        ['n'] = {
          ['D'] = fb_actions.remove,
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['.'] = fb_actions.toggle_hidden,
          ['/'] = function()
            vim.cmd 'startinsert'
          end,
        },
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'file_browser')

-- Keymaps
-- See `:help telescope.builtin`
map('n', '<leader>h', require('telescope.builtin').oldfiles, { desc = 'Files [H]istory' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Fuzzy finder' })
map('n', '<C-g>', require('telescope.builtin').live_grep, { desc = 'Live [G]rep' })
map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
map('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
map('n', '<leader>e', require('telescope').extensions.file_browser.file_browser, { desc = '[F]ile [B]rowser' })
-- map('n', '<leader>fb', function()
--   require('telescope').extensions.file_browser.file_browser {
--     path = '%:p:h',
--     respect_gitignore = false,
--     hidden = true,
--     grouped = true,
--     previewer = false,
--     initial_mode = 'normal',
--     layout_config = { height = 40 },
--   }
-- end)
