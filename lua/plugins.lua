-- plugins.lua

-- Bootstrap packer.nvim if it's not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

ensure_packer()

-- Autocommand to reload Neovim whenever you save plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Initialize packer.nvim
require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Dashboard plugin for Neovim
  use({
    'glepnir/dashboard-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
  })

	-- Treesitter for better syntax highlighting and code understanding
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'go', 'lua', 'rust', 'typescript', 'javascript', 'html', 'css' },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- Additional configurations can go here
			})
		end,
	})

  -- Color schemes
  use('navarasu/onedark.nvim')
  use({ 'catppuccin/nvim', as = 'catppuccin' })
  use('xero/miasma.nvim')

  -- Git integration
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use('sindrets/diffview.nvim')
  use('tpope/vim-fugitive')

  -- Spectre for find and replace
  use 'nvim-pack/nvim-spectre'

  -- Indentation detection
  use({
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup({})
    end,
  })

  -- Telescope for fuzzy finding
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  })

  -- LSP and completion
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')         -- Completion plugin
  use('hrsh7th/cmp-nvim-lsp')     -- LSP source for nvim-cmp
  use('saadparwaiz1/cmp_luasnip') -- Snippets source for nvim-cmp
  use('L3MON4D3/LuaSnip')         -- Snippets plugin

  -- File explorer
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- Optional but recommended
      'MunifTanjim/nui.nvim',
    },
  })

  -- Formatting and linting
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

  -- Tailwind CSS tools
  use({
    'luckasRanarison/tailwind-tools.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-telescope/telescope.nvim', opt = true },
      { 'neovim/nvim-lspconfig', opt = true },
    },
    run = ':UpdateRemotePlugins',
  })

  -- C# LSP
  use({
    'seblj/roslyn.nvim',
    ft = 'cs',
    config = function()
      require('roslyn').setup({
        exe = {
          'dotnet',
          '/Users/5pk/.local/share/nvim/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll',
        },
        filewatching = true,
      })
    end,
  })

  -- Harpoon for quick file navigation
  use({
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  -- Additional plugin configurations can go here

  -- Harpoon setup
  require('harpoon').setup()

  -- Lualine setup
  require('lualine').setup({
    sections = {
      lualine_c = {
        { 'filename', path = 1 }, -- Show full path
      },
    },
  })

  -- Gitsigns setup
  require('gitsigns').setup()

	-- Comment.nvim for easy commenting
	use({
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end,
	})

	-- nvim-autopairs for automatic closing of pairs
	use({
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup({})
		end,
	})

	-- friendly-snippets for a collection of snippets
	use('rafamadriz/friendly-snippets')

	-- Go development plugin
	use({
		'ray-x/go.nvim',
		config = function()
			require('go').setup()
		end,
		ft = { 'go', 'gomod' },
	})

  use{ "nvim-neotest/nvim-nio" }
	-- nvim-dap for debugging
	use('mfussenegger/nvim-dap')

	-- nvim-dap-ui for a better debugging UI
	use({
		'rcarriga/nvim-dap-ui',
		requires = { 'mfussenegger/nvim-dap' },
		config = function()
			require('dapui').setup()
		end,
	})

	-- Install delve for debugging Go code
	use('leoluz/nvim-dap-go')
end)

