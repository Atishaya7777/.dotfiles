-- Debug adapter protocol plugins
return {
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handlers = {},
    },
  },
  
  {
    'mfussenegger/nvim-dap',
    config = function(_, _)
      -- PLUGIN: dapui keybindings
      vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', {
        desc = 'Add breakpoint at line',
      })
      vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', {
        desc = 'Start or continue the debugger',
      })
    end,
  },
}
