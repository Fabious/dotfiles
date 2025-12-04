local lsp_attach_group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_attach_group,
  desc = 'Setup LSP keymaps and format-on-save',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    -- if client and client:supports_method('textDocument/formatting') then
    --   local format_group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true })
    --   vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = format_group,
    --     buffer = bufnr,
    --     callback = function(args)
    --       require('conform').format({ bufnr = args.buf })
    --     end,
    --   })
    -- end

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
    end

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    -- Many servers do not implement declaration method. Generally, see vim.lsp.buf.definition() instead.
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- nmap(']e', vim.diagnostic.jump({ count = 1, float = true }), 'Goto next diagnostic')
    -- nmap('[e', vim.diagnostic.jump({ count = -1, float = true }), 'Goto previous diagnostic')
    nmap(']e', function()
      vim.diagnostic.goto_next({ float = true })
    end, 'Next Diagnostic')
    nmap('[e', function()
      vim.diagnostic.goto_prev({ float = true })
    end, 'Previous Diagnostic')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    -- Create a buffer-local command for formatting
    -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
    --   vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
    -- end, { desc = 'Format current buffer with LSP' })

    -- Handle the illuminate plugin if you use it
    -- require('illuminate').on_attach(client)
  end,
})

local function config(customConfig)
  return vim.tbl_deep_extend('force', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
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
      'saghen/blink.cmp',
      'b0o/schemastore.nvim',
      -- 'RRethy/vim-illuminate',
    },
    opts = { diagnostics = { virtual_text = false } },
    config = function()
      -- Show inline diagnostic
      -- vim.diagnostic.config({
      --   virtual_text = {
      --     prefix = '●', -- Or any other character you like
      --     source = 'if_many', -- Only show source if there are multiple
      --     spacing = 4,
      --   },
      --   signs = true,
      --   underline = true,
      --   update_in_insert = false,
      --   severity_sort = true,
      -- })

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')
      vim.lsp.config['eslint'] = config()
      vim.lsp.config['ts_ls'] = config()
      vim.lsp.config['cssls'] = config()
      vim.lsp.config['html'] = config()
      vim.lsp.config['tailwindcss'] = config()
      vim.lsp.config['phpactor'] = config({
        init_options = {
          ['language_server_phpstan.enabled'] = false,
          ['language_server_psalm.enabled'] = false,
        },
      })
      vim.lsp.config['jsonls'] = config({
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.config['lua_ls'] = config({
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
      })

      vim.lsp.enable({
        'cssls',
        'eslint',
        'html',
        'jsonls',
        'lua_ls',
        'phpactor',
        'tailwindcss',
        'ts_ls',
      })
    end,
  },

  -- formatters
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        lua = { 'stylua' },
        php = { 'phpcsfixer' },
        go = { 'gofmt' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
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
        'phpactor',
        'json-lsp',
        'lua-language-server',
        'rust-analyzer',
        'tailwindcss-language-server',
        'typescript-language-server',
      },
    },
    -- config = function(_, opts)
    --   require('mason').setup(opts)
    --   local mr = require('mason-registry')
    --   local function ensure_installed()
    --     for _, tool in ipairs(opts.ensure_installed) do
    --       local p = mr.get_package(tool)
    --       if not p:is_installed() then
    --         p:install()
    --       end
    --     end
    --   end
    --   if mr.refresh then
    --     mr.refresh(ensure_installed)
    --   else
    --     ensure_installed()
    --   end
    -- end,
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
