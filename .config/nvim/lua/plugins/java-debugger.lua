return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require('dapui').setup()
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require('dap')
      dap.configurations.java = {
        {
          name = "Debug Current Class",
          type = "java",
          request = "launch",
          program = "${file}",
        },
        {
          name = "Debug (Attach) - Remote",
          type = "java",
          request = "attach",
          hostName = "127.0.0.1",
          port = 5005,
        },
     }

      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        vim.cmd.Neotree('close')
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        vim.cmd.Neotree('close')
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        vim.cmd.Neotree('show')
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        vim.cmd.Neotree('show')
        dapui.close()
      end

      -- setup debug
      vim.keymap.set('n', '<F10>',
        function()
          dap.continue()
        end,
        { desc = "Start Debugging" }
      )

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "Add Breakpoint" })
      vim.keymap.set('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { desc = "Add Breakpoint with Condition" })
      vim.keymap.set('n', '<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Logpoint message: "))<CR>', { desc = "Add Logpoint" })

      -- move in debug
      vim.keymap.set('n', '<F5>', ':lua require"dap".continue()<CR>', { desc = "Continue" })
      vim.keymap.set('n', '<F8>', ':lua require"dap".step_over()<CR>', { desc = "Step Over" })
      vim.keymap.set('n', '<F7>', ':lua require"dap".step_into()<CR>', { desc = "Step Into" })
      vim.keymap.set('n', '<S-F8>', ':lua require"dap".step_out()<CR>', { desc = "Step Out" })
      vim.keymap.set('n', '<F2>', ':lua require"dap".terminate()<CR>', { desc = "Terminate" })
    end,
  },
  {
    -- jdtls should be already installed via Mason, this plugin is added for the usage of its APIs only
    "mfussenegger/nvim-jdtls"
  }
}