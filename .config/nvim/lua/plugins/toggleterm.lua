return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<C-t>]],
        insert_mappings = true,
        shade_terminals = false,
        direction = 'horizontal',
        size = function(term)
          if term.direction == "horizontal" then
            return 12
          elseif term.direction == "vertical" then
            return 116
        end
     end
    }
    end,
}
