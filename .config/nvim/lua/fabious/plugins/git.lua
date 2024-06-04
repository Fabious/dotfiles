return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map('n', ']h', gs.next_hunk, 'Next Hunk')
        map('n', '[h', gs.prev_hunk, 'Prev Hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>ghp', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>ghb', function()
          gs.blame_line({ full = true })
        end, 'Blame Line')
        map('n', '<leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<leader>ghD', function()
          gs.diffthis('~')
        end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
      end,
    },
  },
  { 'sindrets/diffview.nvim' },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('gitlinker').setup({
        callbacks = {
          ['gitlab.ftven.net'] = require('gitlinker.hosts').get_gitlab_type_url,
        },
      })
    end,
    keys = {
      {
        '<leader>gY',
        '<cmd>lua require"gitlinker".get_repo_url()<cr>',
        desc = 'Get repo url',
      },
      {
        '<leader>gB',
        '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        desc = 'Open repo in browser',
      },
      {
        '<leader>gb',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        desc = 'Open git line in browser',
      },
      {
        '<leader>gb',
        mode = 'v',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        desc = 'Open git lines range in browser',
      },
    },
  },
}
