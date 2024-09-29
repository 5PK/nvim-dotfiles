-- nvim-dap setup
local dap = require('dap')

-- nvim-dap-ui setup
require('dapui').setup()

-- nvim-dap-go setup
require('dap-go').setup()

-- Key mappings for debugging
vim.keymap.set('n', '<F5>', dap.continue, { noremap = true, silent = true, desc = 'Start/Continue Debugging' })
vim.keymap.set('n', '<F10>', dap.step_over, { noremap = true, silent = true, desc = 'Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { noremap = true, silent = true, desc = 'Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { noremap = true, silent = true, desc = 'Step Out' })
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { noremap = true, silent = true, desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<Leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { noremap = true, silent = true, desc = 'Set Conditional Breakpoint' })
  vim.keymap.set('n', '<Leader>dr', dap.repl.open, { noremap = true, silent = true, desc = 'Open Debug REPL' })

  -- Automatically open and close dap-ui when debugging starts and ends
  dap.listeners.after.event_initialized['dapui_config'] = function()
    require('dapui').open()
	end
	dap.listeners.before.event_terminated['dapui_config'] = function()
	  require('dapui').close()
	  end
	  dap.listeners.before.event_exited['dapui_config'] = function()
	    require('dapui').close()
		end

