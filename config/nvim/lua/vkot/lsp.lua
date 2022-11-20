require("nvim-lsp-installer").setup({})

local popup_opts = { border = "single", focusable = false }
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { signs = false, virtual_text = false })

local lspconfig = require("lspconfig")
local custom_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Key maps. {{{2
local setup_key_mappings = function(bufnr)
  local opts = { buffer = bufnr }
  -- references
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<Leader>gR", function()
    vim.lsp.buf.references({ includeDeclaration = false })
  end, opts)
  vim.keymap.set("n", "<Leader>gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)

  -- actions
  vim.keymap.set("n", "<Leader>ga", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<M-Enter>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<Leader>ga", vim.lsp.buf.range_code_action, opts)
  vim.keymap.set("v", "<M-Enter>", vim.lsp.buf.range_code_action, opts)
  vim.keymap.set("n", "<Leader>gq", vim.lsp.buf.formatting, opts)
  vim.keymap.set("n", "<Leader>ar", vim.lsp.buf.rename, opts)

  -- lists
  vim.keymap.set("n", "<Leader>lO", vim.lsp.buf.document_symbol, opts)
  vim.keymap.set("n", "<Leader>lS", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<Leader>lG", vim.diagnostic.setloclist)

  vim.keymap.set("n", "<C-Space>", function()
    vim.diagnostic.open_float(0, { scope = "line" })
  end, opts)
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
  vim.keymap.set("n", "<Leader>lg", function()
    require("telescope.builtin").diagnostics({
      bufnr = 0,
    })
  end, opts)
end

-- Attach handler. {{{2
local attach_formatting = function()
  vim.api.nvim_command([[augroup Format]])
  vim.api.nvim_command([[autocmd! * <buffer>]])
  vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)]])
  vim.api.nvim_command([[augroup END]])
end

local custom_attach = function(client)
  setup_key_mappings(0)

  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr")
  if client.server_capabilities.document_formatting then
    attach_formatting()
  end
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

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,
  capabilities = custom_capabilities,
})

local ltex_path = vim.fn.stdpath("data") .. "/lsp_servers/ltex/ltex-ls"
if vim.fn.exepath(ltex_path) ~= "" then
  lspconfig.ltex.setup({
    cmd = { ltex_path },
    on_attach = custom_attach,
    capabilities = custom_capabilities,
    settings = {
      ltex = {
        disabledRules = { ["en-US"] = { "EN_QUOTES" } },
        additionalRules = { enablePickyRules = true },
      },
    },
  })
end

lspconfig.tsserver.setup({
  on_attach = function(client)
    custom_attach(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end,
  capabilities = custom_capabilities,
  cmd = { "typescript-language-server", "--stdio" },
})

local dockerized_servers = {
  "bashls",
  "dockerls",
  "html",
  "jsonls",
  "pyright",
  "yamlls",
  "sumneko_lua",
}

for _, server in pairs(dockerized_servers) do
  lspconfig[server].setup({
    before_init = function(params)
      params.processId = vim.NIL
    end,
    cmd = require("lspcontainers").command(server),
    root_dir = lspconfig.util.find_git_ancestor,
    on_attach = function(client)
      custom_attach(client)
    end,
    capabilities = custom_capabilities,
  })
end

-- Diagnostics. {{{3
lspconfig.diagnosticls.setup({
  on_attach = custom_attach,
  capabilities = custom_capabilities,
  filetypes = {
    "lua",
    "markdown",
    "rst",
  },
  init_options = {
    filetypes = {
      markdown = "proselint",
      rst = "proselint",
    },
    linters = {
      proselint = {
        command = "proselint",
        debounce = 100,
        args = { "-j", "%filepath" },
        sourceName = "proselint",
        parseJson = {
          errorsRoot = "data.errors",
          line = "line",
          column = "column",
          message = "[proselint] ${message} (${check})",
          security = "severity",
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "suggestion",
        },
      },
    },
    formatters = {
      styluaFix = {
        command = "stylua",
        args = { "%filepath", "--search-parent-directories" },
        rootPatterns = { ".git" },
      },
    },
    formatFiletypes = {
      lua = "styluaFix",
    },
  },
})
