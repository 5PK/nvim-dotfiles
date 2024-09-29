-- Bootstrap packer.nvim if it's not already install
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Initialize packer.nvim if it isn't already
require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'  -- Packer manager

  -- Dashboard plugin for Neovim
  use {
    'glepnir/dashboard-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' } -- Optional: Adds icons
  }
  use 'nvim-treesitter/nvim-treesitter'

  -- Onedark color scheme
  use 'navarasu/onedark.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'xero/miasma.nvim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use 'sindrets/diffview.nvim'
  use 'tpope/vim-fugitive'
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }
  -- Telescope and its dependency plenary.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
     -- or                            , branch = '0.1.x',
     requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- LSP configurations for Neovim
  use 'neovim/nvim-lspconfig'
  -- Optional: Autocompletion plugins (recommended)
  use 'hrsh7th/nvim-cmp'         -- Completion plugin
  use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'         -- Snippets plugin
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }

  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')  
  
  use {
    'luckasRanarison/tailwind-tools.nvim',
    config = function()
      -- Your configuration goes here
    end,
    -- Specify dependencies
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-telescope/telescope.nvim', opt = true },
      { 'neovim/nvim-lspconfig', opt = true },
    },
    run = ':UpdateRemotePlugins',
  }
  use {
    'seblj/roslyn.nvim',
    ft = 'cs', -- Load this plugin only when editing C# files
    config = function()
      -- Configuration for roslyn.nvim
      require('roslyn').setup({
        config = {
          -- Here you can pass in any options that you would like to pass to `vim.lsp.start`.
          -- Use `:h vim.lsp.ClientConfig` to see all possible options.
          -- The only options that are overwritten and won't have any effect by setting here:
          --     - `name`
          --     - `cmd`
          --     - `root_dir`
        },

        exe = {
          "dotnet",
          "/Users/5pk/.local/share/nvim/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll", -- Hardcoded path
        },

        -- Set `filewatching` to false if you experience performance problems.
        filewatching = true,

        -- Optional function to choose a specific solution
        choose_sln = nil, -- You can provide your own function here if needed
      })
    end
  }

  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
end)

local harpoon = require("harpoon")
harpoon:setup()

vim.o.ignorecase = true
vim.o.smartcase = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Also show the absolute line number on the current line
vim.opt.number = true

vim.g.mapleader = " "  -- Set leader to spacebar
-- Create mappings
-- Mapping for harpoon functions

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) 

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>[", function() harpoon:list():prev() end,{ noremap = true, silent = true } )
vim.keymap.set("n", "<leader>]", function() harpoon:list():next() end,{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>dvo', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dvc', ':DiffviewClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pf', function() 
  require('telescope.builtin').find_files({
    no_ignore = true,   -- Show ignored files (e.g., files in .gitignore)
    hidden = true       -- Show hidden files (e.g., dotfiles)
  })
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>zz", { noremap = true, silent = true })

--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- Map <leader>lg to :Telescope live_grep
vim.api.nvim_set_keymap('n', '<leader>lg', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Map <leader>op to :Neotree toggle
vim.api.nvim_set_keymap('n', '<leader>tr', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Prettier<CR>', { noremap = true, silent = true })

-- Remap Ctrl+d to scroll down and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- Remap Ctrl+u to scroll up and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Remap 'n' to search and center the screen
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })

-- Remap 'N' to search backwards and center the screen
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- remap l to turn on and off rel line numbers
vim.api.nvim_set_keymap('n', '<leader>ln', ':set relativenumber!<CR>', { noremap = true, silent = true })


-- Map <C-f9> to exit insert mode (Esc) and write the file (:w)
vim.api.nvim_set_keymap('n', '<F9>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-F9>', '<Esc>:w<CR>', { noremap = true, silent = true })

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>fm", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>fm", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})


require("tailwind-tools").setup({
  server = {
    override = true, -- setup the server from the plugin if true
    settings = {}, -- shortcut for `settings.tailwindCSS`
    on_attach = function(client, bufnr) end, -- callback triggered when the server attaches to a buffer
  },
  document_color = {
    enabled = true, -- can be toggled by commands
    kind = "inline", -- "inline" | "foreground" | "background"
    inline_symbol = "󰝤 ", -- only used in inline mode
    debounce = 200, -- in milliseconds, only applied in insert mode
  },
  conceal = {
    enabled = false, -- can be toggled by commands
    min_length = nil, -- only conceal classes exceeding the provided length
    symbol = "󱏿", -- only a single character is allowed
    highlight = { -- extmark highlight options, see :h 'highlight'
      fg = "#38BDF8",
    },
  },
  cmp = {
    highlight = "foreground", -- color preview style, "foreground" | "background"
  },
  telescope = {
    utilities = {
      callback = function(name, class) end, -- callback used when selecting an utility class in telescope
    },
  },
  -- see the extension section to learn more
  extension = {
    queries = {}, -- a list of filetypes having custom `class` queries
    patterns = { -- a map of filetypes to Lua pattern lists
      -- exmaple:
      -- rust = { "class=[\"']([^\"']+)[\"']" },
      -- javascript = { "clsx%(([^)]+)%)" },
    },
  },
})

vim.cmd('colorscheme catppuccin-macchiato')

-- Change the color of absolute line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9E9E9E', bg = '#23273B' })

-- Change the color of relative line numbers
vim.api.nvim_set_hl(0, 'LineNrRelative', { fg = '#9E9E9E', bg = '#23273B' })

-- Optionally, change the color of the current line number (the line where the cursor is)
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#9E9E9E', bold = true })

require('dashboard').setup({

  theme = 'doom', -- Use the 'doom' theme for a layout similar to your screenshot
  config = {
  header={

"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"                                                             /)                              ",
"                                                   /\\___/\\ ((                              ",
"                           |\\__/,|   (`\\            \\`@_@'/  ))                               ",
"                          _.|o o  |_   ) )           {_:Y:.}_//                                ",
"                         -(((---(((------------------{_}^-'{_}-------                          ",
"                        ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄                           ",
"                        █  █  █ █       █       █  █ █  █   █  █▄█  █                         ",
"        |\\__/,|   (`\\ █   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █  _._     _,-'\"\"`-._   ",
"        |_ _  |.--.) )  █       █   █▄▄▄█  █ █  █       █   █       █ (,-.`._,'(       |\\`-/|",
"        ( T   )     /   █  ▄    █    ▄▄▄█  █▄█  █       █   █       █     `-.-' \\ )-`( , o o)",
"        (((^_(((/(((_/ █ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █          `-    \\`_`\"'-",
"                        █▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█                         ",
"                     |\\      _,,,---,,_               /\\_/\\           ___               ",
"               ZZZzz /,`.-'`'    -.  ;-;;,_        = o_o =_______    \\ \\            ",
"                     |,4-  ) )-,_. ,\\ (  `'-'        __^      __(  \\.__) )            ",
"                     '---''(_/--'  `-'\\_)          (@)<_____>__(_____)____/              ",
"",
"",
"",
"",
"",
"",
"",
"",
"",
},
    center = {
      {
        icon = '  ',
        desc = 'Find File                   ',
        key = 'f',
        action = 'Telescope find_files'
      },
      {
        icon = '  ',
        desc = 'New file                    ',
        key = 'e',
        action = 'enew'
      },
      {
        icon = '  ',
        desc = 'Recent files                ',
        key = 'r',
        action = 'Telescope oldfiles'
      },
      {
        icon = '󰊄  ',
        desc = 'Find text                   ',
        key = 't',
        action = 'Telescope live_grep'
      },
      {
        icon = '  ',
        desc = 'Configuration               ',
        key = 'c',
        action = 'edit ~/.config/nvim/init.lua'
      },
      {
        icon = '  ',
        desc = 'Update Plugins              ',
        key = 'u',
        action = 'PackerSync'
      },
      {
        icon = '󰩈  ',
        desc = 'Quit Neovim                 ',
        key = 'q',
        action = 'qa'
      },
    },
    footer = { "v0.9.0 and 36 Plugins" },
  },
})


require('lualine').setup({
  sections = {
    lualine_c = {
      { 'filename', path = 1 }  -- Set path = 1 to show the full path
    }
  }
})
require('gitsigns').setup()

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['ts_ls'].setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Your custom on_attach function here
  end,
}

require'lspconfig'.rust_analyzer.setup{
    -- You can add your specific configuration here.
    on_attach = function(_, bufnr)
        local opts = { noremap=true, silent=true }
        -- Keybindings for LSP actions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        }
    }
}

-- Import the nvim-tree plugin safely
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- Recommended settings for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



-- Setup nvim-tree with some basic options
nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 30,
    side = "left",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
})


local lspconfig = require('lspconfig')
local cmp = require'cmp'

-- Setup nvim-cmp for autocompletion
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}


vim.g.dashboard_default_executive = 'telescope'

