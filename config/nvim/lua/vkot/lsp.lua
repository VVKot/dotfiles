require("nvim-lsp-installer").setup({})

local popup_opts = { border = "single", focusable = false }
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { signs = false, virtual_text = false })

local lspconfig = require("lspconfig")
local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = require("cmp_nvim_lsp").update_capabilities(custom_capabilities)

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

  -- Typescript utils
  vim.keymap.set("n", "<Leader>af", function()
    vim.cmd([[TSLspImportAll]])
  end, opts)
  vim.keymap.set("n", "<Leader>ao", function()
    vim.cmd([[TSLspOrganize]])
  end, opts)
  vim.keymap.set("n", "<Leader>ai", function()
    vim.cmd([[TSLspImportCurrent]])
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

lspconfig.sumneko_lua.setup({
  cmd = require("lspcontainers").command("sumneko_lua"),
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require("lspcontainers").command("sumneko_lua", {
      root_dir = new_root_dir,
    })
  end,
  on_attach = custom_attach,
  capabilities = custom_capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "describe", "it", "before_each", "after_each" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

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
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)
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
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "css",
    "scss",
    "sass",
    "less",
    "lua",
    "markdown",
    "rst",
  },
  init_options = {
    filetypes = {
      css = "stylelint",
      scss = "stylelint",
      sass = "stylelint",
      less = "stylelint",
      markdown = "proselint",
      rst = "proselint",
    },
    linters = {
      stylelint = {
        command = "./node_modules/.bin/stylelint",
        rootPatterns = { ".git" },
        debounce = 100,
        args = { "%filepath", "--formatter", "json" },
        sourceName = "stylelint",
        parseJson = {
          errorsRoot = "[0].warnings",
          line = "line",
          column = "column",
          message = "[stylelint] ${text}",
          security = "severity",
        },
      },
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
      eslintFix = {
        command = "./node_modules/.bin/eslint",
        args = { "%filepath", "--fix" },
        rootPatterns = { ".git" },
      },
      stylelintFix = {
        command = "./node_modules/.bin/stylelint",
        args = { "%filepath", "--fix" },
        rootPatterns = { ".git" },
      },
      styluaFix = {
        command = "stylua",
        args = { "%filepath", "--search-parent-directories" },
        rootPatterns = { ".git" },
      },
    },
    formatFiletypes = {
      javascript = "eslintFix",
      javascriptreact = "eslintFix",
      ["javascript.jsx"] = "eslintFix",
      typescript = "eslintFix",
      typescriptreact = "eslintFix",
      ["typescript.tsx"] = "eslintFix",
      css = "stylelintFix",
      scss = "stylelintFix",
      sass = "stylelintFix",
      less = "stylelintFix",
      lua = "styluaFix",
    },
  },
})

lspconfig.jdtls.setup({
  on_attach = function(client)
    custom_attach(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end,
  capabilities = custom_capabilities,
  use_lombok_agent = true,
})

-- Servers with default setup. {{{3
local servers = { "vimls", "cssls", "eslint" }

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = custom_attach,
    capabilities = custom_capabilities,
  })
end
