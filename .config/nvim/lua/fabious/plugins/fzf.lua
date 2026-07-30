local function pick(fn, opts)
  return function()
    require('fzf-lua')[fn](opts)
  end
end

-- Files changed against the repo's default branch, falling back to dev-main.
local function changed_vs_default()
  local fzf = require('fzf-lua')
  local head = vim.fn.systemlist({ 'git', 'symbolic-ref', '--short', 'refs/remotes/origin/HEAD' })[1]
  local base = head and head:gsub('^origin/', '') or nil
  if vim.v.shell_error ~= 0 or not base or base == '' then
    base = 'dev-main'
  end
  fzf.fzf_exec({ 'git', 'diff', '--name-only', base }, {
    prompt = 'Changed vs ' .. base .. '> ',
    previewer = 'builtin',
    actions = fzf.defaults.actions.files,
  })
end

return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      fzf_opts = { ['--layout'] = 'reverse' },
      winopts = { preview = { default = 'builtin' } },
    })

    -- Replaces telescope-ui-select: routes vim.ui.select through fzf.
    fzf.register_ui_select()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('fzf-lsp-attach', { clear = true }),
      callback = function(event)
        local function map(keys, fn, desc)
          vim.keymap.set('n', keys, pick(fn), { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grr', 'lsp_references', '[G]oto [R]eferences')
        map('gri', 'lsp_implementations', '[G]oto [I]mplementation')
        map('grd', 'lsp_definitions', '[G]oto [D]efinition')
        map('grt', 'lsp_typedefs', '[G]oto [T]ype Definition')
        map('gO', 'lsp_document_symbols', 'Open Document Symbols')
        map('gW', 'lsp_live_workspace_symbols', 'Open Workspace Symbols')
        map('<leader>fi', 'lsp_incoming_calls', '[F]ind [i]ncoming calls')
      end,
    })
  end,
  keys = {
    { '<C-p>', pick('git_files'), desc = 'Fuzzy finder' },
    { '<C-g>', pick('live_grep'), desc = 'Live [G]rep' },
    { '<F1>', pick('helptags'), desc = '[F]ind [H]elp' },
    { '<leader><leader>', pick('buffers'), desc = '[ ] Find existing buffers' },
    { '<leader>h', pick('oldfiles'), desc = '[H]istory' },
    { '<leader>ff', pick('files'), desc = '[F]ind [F]iles' },
    { '<leader>fk', pick('keymaps'), desc = '[F]ind [K]eymaps' },
    { '<leader>fs', pick('builtin'), desc = '[F]ind [S]elect fzf-lua' },
    { '<leader>fw', pick('grep_cword'), desc = '[F]ind current [W]ord' },
    { '<leader>fw', pick('grep_visual'), mode = 'v', desc = '[F]ind selection' },
    { '<leader>fg', pick('git_status'), desc = '[F]ind by [G]it status' },
    { '<leader>fd', pick('diagnostics_document'), desc = '[F]ind [D]iagnostics' },
    { '<leader>fr', pick('lsp_references'), desc = '[F]ind [R]eferences' },
    { '<leader>fc', pick('commands'), desc = '[F]ind [C]ommands' },
    { '<leader>fx', pick('diagnostics_workspace'), desc = '[F]ind workspace diagnostics' },
    { '<leader>/', pick('lgrep_curbuf'), desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', pick('lines'), desc = '[F]ind [/] in open buffers' },
    {
      '<leader>fn',
      pick('files', { cwd = vim.fn.stdpath('config') }),
      desc = '[F]ind [N]eovim files',
    },
    { '<leader>gm', changed_vs_default, desc = 'Find files changed vs default branch' },
  },
}
