return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      delay = 200,
    })
    wk.add({
      -- Examples of other common groups you might want to add later:
      -- { "<leader>f", group = "Find/File" },
      -- { "<leader>w", group = "Window" },
      -- { "<leader>b", group = "Buffer" },
    })
  end
}
