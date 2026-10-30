-- nvim-treesitter `main` branch: it only installs parsers and queries.
-- Highlighting, indent and selection are Neovim's own, enabled per buffer below.
-- Needs the tree-sitter CLI and a C compiler to build parsers.
local ensure_installed = {
  'c',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- the main branch doesn't support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.install(ensure_installed)

      local function attach(buf)
        if pcall(vim.treesitter.start, buf) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('fabious_treesitter', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          -- Same as the old `auto_install = true`: fetch a missing parser, then attach.
          if
            not vim.tbl_contains(ts.get_installed(), lang)
            and vim.tbl_contains(ts.get_available(), lang)
          then
            ts.install(lang):await(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                attach(args.buf)
              end
            end)
            return
          end
          attach(args.buf)
        end,
      })

      -- Incremental selection is built into Neovim 0.12 (`an` / `in` in visual
      -- mode); keep the old <c-space> / <c-backspace> keys on top of it.
      vim.keymap.set('n', '<c-space>', 'van', { remap = true, desc = 'Select treesitter node' })
      vim.keymap.set('x', '<c-space>', 'an', { remap = true, desc = 'Select parent node' })
      vim.keymap.set('x', '<c-backspace>', 'in', { remap = true, desc = 'Select child node' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        },
        move = {
          set_jumps = true, -- whether to set jumps in the jumplist
        },
      })

      -- You can use the capture groups defined in textobjects.scm
      local select = require('nvim-treesitter-textobjects.select')
      for keys, query in pairs({
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }) do
        vim.keymap.set({ 'x', 'o' }, keys, function()
          select.select_textobject(query, 'textobjects')
        end)
      end

      local move = require('nvim-treesitter-textobjects.move')
      for fn, maps in pairs({
        goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
        goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
        goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
        goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
      }) do
        for keys, query in pairs(maps) do
          vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
            move[fn](query, 'textobjects')
          end)
        end
      end

      local swap = require('nvim-treesitter-textobjects.swap')
      vim.keymap.set('n', '<leader>a', function()
        swap.swap_next('@parameter.inner')
      end)
      vim.keymap.set('n', '<leader>A', function()
        swap.swap_previous('@parameter.inner')
      end)
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    opts = {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == 'typescriptreact' then
          local U = require('Comment.utils')

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,
    },
  },
}
