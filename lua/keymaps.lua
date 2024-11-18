-- keymaps.lua

-- Harpoon key mappings
local harpoon = require('harpoon')

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) 

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>-", vim.diagnostic.open_float, { noremap = true, silent = true })


-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>[", function() harpoon:list():prev() end,{ noremap = true, silent = true } )
vim.keymap.set("n", "<leader>]", function() harpoon:list():next() end,{ noremap = true, silent = true })

-- Diffview key mappings
vim.api.nvim_set_keymap('n', '<leader>dvo', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dvc', ':DiffviewClose<CR>', { noremap = true, silent = true })

-- Telescope key mappings
vim.keymap.set('n', '<leader>pf', function()
  require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
    no_ignore = true,
    hidden = true,
    previewer = false}))
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').git_files(require('telescope.themes').get_dropdown({previewer = false}))
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lg', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- LSP key mappings
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', { noremap = true, silent = true })

-- Neo-tree key mapping
vim.api.nvim_set_keymap('n', '<leader>tr', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- Prettier key mapping
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Prettier<CR>', { noremap = true, silent = true })

-- Scrolling and search centering
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Toggle relative line numbers
vim.api.nvim_set_keymap('n', '<leader>ln', ':set relativenumber!<CR>', { noremap = true, silent = true })

-- Save file mappings
vim.api.nvim_set_keymap('n', '<F9>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-F9>', '<Esc>:w<CR>', { noremap = true, silent = true })
