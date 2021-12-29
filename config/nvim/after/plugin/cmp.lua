local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init()

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "ultisnips" },
    { name = "buffer", keyword_length = 5, max_item_count = 5 },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        nvim_lua = "[nvim_lua]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        ultisnips = "[snip]",
        buffer = "[buf]",
      },
    }),
  },
  experimental = { native_menu = false, ghost_text = false },
})
