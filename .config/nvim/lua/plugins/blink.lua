return {
  "saghen/blink.cmp",
  -- Pin to a release to download pre-built binaries
  version = "1.*", 
  
  dependencies = {
    -- Optional: Provides a huge collection of pre-written snippets
    "rafamadriz/friendly-snippets",
  },

  opts = {
    -- Choose your keymap preset: 
    -- 'default'   (Use <C-space> to trigger, <C-n>/<C-p> to navigate, <C-y> to accept)
    -- 'super-tab' (Use <Tab> to navigate and accept)
    -- 'enter'     (Use <Enter> to accept)
    keymap = { preset = "enter" },

    appearance = {
      -- Fallback to nvim-cmp highlights if your theme doesn't support blink yet
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- blink.cmp ships with these sources out-of-the-box
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    
    -- Experimental signature help (shows parameter hints as you type)
    signature = { enabled = true }
  },
  
  -- Allows extending the sources array elsewhere in your config without replacing it entirely
  opts_extend = { "sources.default" } 
}
