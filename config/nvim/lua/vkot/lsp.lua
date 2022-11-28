local popup_opts = { border = "single", focusable = false }
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { signs = false, virtual_text = false })

local lspconfig = require("lspconfig")
local custom_capabilities = vim.lsp.protocol.make_client_capabilities()

-- Key maps. {{{2
local setup_key_mappings = function()
  local opts = { buffer = true }
  -- references
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<Leader>gR", function()
    vim.lsp.buf.references({ includeDeclaration = false })
  end, opts)

  -- actions
  vim.keymap.set("n", "<M-Enter>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<M-Enter>", vim.lsp.buf.range_code_action, opts)
  vim.keymap.set("n", "<Leader>ar", vim.lsp.buf.rename, opts)

  -- lists
  vim.keymap.set("n", "<Leader>lO", vim.lsp.buf.document_symbol, opts)
  vim.keymap.set("n", "<Leader>lg", vim.diagnostic.setloclist)

  vim.keymap.set("n", "]g", function()
    vim.diagnostic.goto_next({ float = popup_opts })
  end, opts)
  vim.keymap.set("n", "[g", function()
    vim.diagnostic.goto_prev({ float = popup_opts })
  end, opts)

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
end

-- Attach handler. {{{2

local custom_attach = function()
  setup_key_mappings()
end

-- Servers. {{{2

lspconfig.gopls.setup({
  on_attach = custom_attach,
  capabilities = custom_capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

local dockerized_servers = {
  "bashls",
  "clangd",
  "dockerls",
  "html",
  "jsonls",
  "pyright",
  "sumneko_lua",
  "tsserver",
  "yamlls",
}

for _, server in pairs(dockerized_servers) do
  lspconfig[server].setup({
    before_init = function(params)
      params.processId = vim.NIL
    end,
    cmd = require("lspcontainers").command(server),
    root_dir = lspconfig.util.find_git_ancestor,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
  })
end
