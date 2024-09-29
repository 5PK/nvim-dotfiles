-- settings.lua

-- General settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.relativenumber = true
vim.opt.number = true

-- Leader key
vim.g.mapleader = " "  -- Set leader to spacebar

-- Tab and indent settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Colorscheme
vim.cmd('colorscheme catppuccin-macchiato')

-- Highlighting for line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9E9E9E', bg = '#23273B' })
vim.api.nvim_set_hl(0, 'LineNrRelative', { fg = '#9E9E9E', bg = '#23273B' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#9E9E9E', bold = true })

-- Netrw settings (if using nvim-tree or neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

