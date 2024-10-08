return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v4.x",
  dependencies = {
    { "neovim/nvim-lspconfig" }, -- Required, for storing pre-made configurations for various language servers (LS)
    { "williamboman/mason.nvim" },-- For installing many multiple kinds of language servers and DAPs
    { "williamboman/mason-lspconfig.nvim" }, -- Integration plugin which bridges lspconfig and mason

    { "hrsh7th/nvim-cmp" }, -- Required, core autocompletion plugin
    { "hrsh7th/cmp-nvim-lsp" },

    { "L3MON4D3/LuaSnip" }, -- Required
    { "saadparwaiz1/cmp_luasnip" },

    { "hrsh7th/cmp-buffer" }, -- Autocompletion for buffer
    { "hrsh7th/cmp-path" }, -- Autocompletion of system paths
    { "hrsh7th/cmp-cmdline" }, -- Autocompletion of commands
    { "rafamadriz/friendly-snippets" }, -- Quickly generate code snippet, e.g., psvm -> public static void main(...)
  },
  config = function()
    local lsp = require("lsp-zero")

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))

      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.setloclist() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))

      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
    end)

    -- Install language servers via Mason
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "jdtls",
        "lua_ls",
      },
      handlers = {
        lsp.default_setup,
        lua_ls = function()
          local lua_opts = lsp.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
      },
    })

    local cmp_action = require("lsp-zero").cmp_action()
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    -- this is the function that loads the extra snippets
    -- from rafamadriz/friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      },
      {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      },
      mapping = cmp.mapping.preset.insert({
        -- Tab for completion
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item()
              cmp.confirm()
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, { "i", "s" }),

        -- confirm completion item
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      }),
    })
  end,
}
