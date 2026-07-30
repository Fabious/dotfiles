return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
          },
        },
      },
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
      -- path_display can be set to an array with a combination of:
      -- - "hidden"          hide file names
      -- - "tail"            only display the file name, and not the path
      -- - "absolute"        display absolute paths
      -- - "smart"           remove as much from the path as possible to only show
      --                     the difference between the displayed paths.
      --                     Warning: The nature of the algorithm might have a negative
      --                     performance impact!
      -- - "shorten"         only display the first character of each directory in
      --                     the path
      -- - "truncate"        truncates the start of the path when the whole path will
      --                     not fit. To increase the gap between the path and the edge,
      --                     set truncate to number `truncate = 3`
      -- - "filename_first"  shows filenames first and then the directories
      path_display = { 'truncate' },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy finder' })
    vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Live [G]rep' })
    vim.keymap.set('n', '<F1>', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.git_status, { desc = '[F]ind by [G]it status' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = '[F]ind [R]eferences' })
    vim.keymap.set('n', '<leader>h', builtin.oldfiles, { desc = '[H]istory' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>gm', function()
      require('telescope.builtin').find_files({
        prompt_title = 'Modified Files (vs main)',
        find_command = { 'git', 'diff', '--name-only', 'dev-main' },
      })
    end, { desc = 'Find modified files compared to main' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf

        vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
        vim.keymap.set(
          'n',
          '<leader>fi',
          builtin.lsp_incoming_calls,
          { buffer = buf, desc = '[F]ind [i]ncoming calls' }
        )
        vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
        vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
        vim.keymap.set(
          'n',
          'gW',
          builtin.lsp_dynamic_workspace_symbols,
          { buffer = buf, desc = 'Open Workspace Symbols' }
        )
        vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
      end,
    })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = '[F]ind [/] in Open Files' })

    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[F]ind [N]eovim files' })
  end,
}
