-- lsp.lua


-- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

-- nvim-autopairs setup
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Language server configurations
local lspconfig = require('lspconfig')

-- Go language server setup
require('lspconfig').gopls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Custom on_attach function for Go
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- LSP mappings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- Formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('GoFormat', { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
        fieldalignment = true,
      },
      staticcheck = true,
    },
  },
})


-- TypeScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Custom on_attach function
  end,
})

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    -- Keybindings for LSP actions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  end,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

-- Null-ls for formatting and linting
local null_ls = require('null-ls')

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<Leader>fm', function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = '[lsp] format' })
    end

    if client.supports_method('textDocument/rangeFormatting') then
      vim.keymap.set('x', '<Leader>fm', function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = '[lsp] format' })
    end
  end,
})

-- Prettier setup
local prettier = require('prettier')

prettier.setup({
  bin = 'prettier', -- or 'prettierd' (v0.23.3+)
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'yaml',
  },
})

-- Tailwind Tools setup
require('tailwind-tools').setup({
  server = {
    override = true,
    settings = {},
    on_attach = function(client, bufnr)
      -- Custom on_attach
    end,
  },
  document_color = {
    enabled = true,
    kind = 'inline',
    inline_symbol = '󰝤 ',
    debounce = 200,
  },
  conceal = {
    enabled = false,
    min_length = nil,
    symbol = '󱏿',
    highlight = {
      fg = '#38BDF8',
    },
  },
  cmp = {
    highlight = 'foreground',
  },
  telescope = {
    utilities = {
      callback = function(name, class)
        -- Callback function
      end,
    },
  },
  extension = {
    queries = {},
    patterns = {},
  },
})

-- Additional LSP configurations can be added here

