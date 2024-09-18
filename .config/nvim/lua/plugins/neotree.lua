return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  cmd = 'Neotree',
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      -- make a group to be able to delete it later, for clearing netrw window
      group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
      callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd('Neotree position=left dir=' .. f)
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
        end
      end
    })
  end,
  config = function()
      vim.keymap.set('n', '<leader>e',
        function()
          vim.cmd.Neotree('toggle')
        end,
        { desc = "Toggle Neotree" }
      )
  end,
--  opts = {
--    filesystem = {
--      hijack_netrw_behavior = 'open_current'
--    }
--  },
}
