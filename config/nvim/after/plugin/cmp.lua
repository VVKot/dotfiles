local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init({})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), "m", true)
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
        elseif cmp.visible() then
          cmp.confirm()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
        else
          fallback()
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      i = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
        else
          fallback()
        end
      end,
    }),
    ["<C-n>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  }),
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
