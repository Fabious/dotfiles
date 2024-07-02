local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local function config(customConfig)
  return vim.tbl_deep_extend('force', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true })
      end

      nmap('gr', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      -- rmap('gr', require('telescope.builtin').lsp_references)

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
      nmap(']e', vim.diagnostic.goto_next, 'Goto next diagnostic')
      nmap('[e', vim.diagnostic.goto_prev, 'Goto previous diagnostic')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(
        bufnr,
        'Format',
        vim.lsp.buf.format or vim.lsp.buf.formatting,
        { desc = 'Format current buffer with LSP' }
      )

      vim.api.nvim_create_user_command('DisableLspFormatting', function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
      end, { nargs = 0 })

      require('illuminate').on_attach(client)
    end,
  }, customConfig or {})
end

return {
  -- lspconfig
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
      'RRethy/vim-illuminate',
    },
    config = function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')
      require('lspconfig').eslint.setup(config())
      require('lspconfig').tsserver.setup(config())
      require('lspconfig').cssls.setup(config())
      require('lspconfig').tailwindcss.setup(config())
      require('lspconfig').intelephense.setup(config())
      -- Golang
      require('lspconfig').gopls.setup(config({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            gofumpt = true, -- null-ls handle the formatting
            staticcheck = true,
          },
        },
      }))
      -- Rust
      require('lspconfig').rust_analyzer.setup(config({
        settings = {
          ['rust-analyzer'] = {
            imports = {
              granularity = {
                group = 'module',
              },
              prefix = 'self',
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      }))
      require('lspconfig').jsonls.setup(config({
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }))
      require('lspconfig').lua_ls.setup(config({
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
          },
        },
      }))
    end,
  },

  -- formatters
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        debug = true,
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.prettierd,
          -- require('null-ls').builtins.diagnostics.eslint,

          -- Golang
          nls.builtins.formatting.gofmt,
          -- require('null-ls').builtins.formatting.gofumpt, -- stricter than gofmt
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'css-lsp',
        'eslint-lsp',
        'gopls',
        'intelephense',
        'json-lsp',
        'lua-language-server',
        'rust-analyzer',
        'tailwindcss-language-server',
        'typescript-language-server',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- show function signature as you type
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
