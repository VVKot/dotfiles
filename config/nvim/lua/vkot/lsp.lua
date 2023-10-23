vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

local lspconfig = require("lspconfig")

-- Key maps. {{{2

-- diagnostics

local dianostic_popup_opts = { border = "single", focusable = false }
vim.keymap.set("n", "<Leader>lg", vim.diagnostic.setloclist)
vim.keymap.set("n", "]g", function()
  vim.diagnostic.goto_next({ float = dianostic_popup_opts })
end)
vim.keymap.set("n", "[g", function()
  vim.diagnostic.goto_prev({ float = dianostic_popup_opts })
end)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf
    local opts = { buffer = buffer }

    -- references
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", function()
      vim.lsp.buf.references({ includeDeclaration = false })
    end, opts)

    -- actions
    vim.keymap.set({ "n", "v" }, "<M-Enter>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Leader>ar", vim.lsp.buf.rename, opts)

    -- lists
    vim.keymap.set("n", "gl", vim.lsp.buf.document_symbol, opts)

    vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- telescope
    vim.keymap.set("n", "<Leader>gr", function()
      require("telescope.builtin").lsp_references({ includeDeclaration = false })
    end, opts)
    vim.keymap.set("n", "<Leader>lo", function()
      require("telescope.builtin").lsp_document_symbols({})
    end, opts)
    vim.keymap.set("n", "<Leader>ls", function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols({})
    end, opts)
  end,
})

-- Servers. {{{2

lspconfig.gopls.setup({
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

lspconfig.pyright.setup({})
