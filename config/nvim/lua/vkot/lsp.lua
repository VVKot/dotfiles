local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local inoremap = vim.keymap.inoremap

local popup_opts = { border = "single", focusable = false }
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { signs = false, virtual_text = false }
)

local lspconfig = require "lspconfig"
local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = require("cmp_nvim_lsp").update_capabilities(custom_capabilities)

-- Key maps. {{{2
local setup_key_mappings = function(bufnr)
  local opts = { buffer = bufnr }
  -- references
  nnoremap {
    "gd",
    function()
      vim.lsp.buf.definition()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gd",
    function()
      vim.lsp.buf.definition()
    end,
    opts,
  }
  nnoremap {
    "gD",
    function()
      vim.lsp.buf.implementation()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gi",
    function()
      vim.lsp.buf.implementation()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gR",
    function()
      vim.lsp.buf.references()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gy",
    function()
      vim.lsp.buf.type_definition()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gD",
    function()
      vim.lsp.buf.declaration()
    end,
    opts,
  }

  -- actions
  nnoremap {
    "<Leader>gA",
    function()
      vim.lsp.buf.code_action()
    end,
    opts,
  }
  vnoremap {
    "<Leader>gA",
    function()
      vim.lsp.buf.range_code_action()
    end,
    opts,
  }
  nnoremap {
    "<Leader>gq",
    function()
      vim.lsp.buf.formatting()
    end,
    opts,
  }
  nnoremap {
    "<Leader>ar",
    function()
      vim.lsp.buf.rename()
    end,
    opts,
  }

  -- lists
  nnoremap {
    "<Leader>lO",
    function()
      vim.lsp.buf.document_symbol()
    end,
    opts,
  }
  nnoremap {
    "<Leader>lS",
    function()
      vim.lsp.buf.workspace_symbol()
    end,
    opts,
  }
  nnoremap {
    "<Leader>lG",
    function()
      vim.lsp.diagnostic.set_loclist()
    end,
    opts,
  }

  nnoremap {
    "<C-Space>",
    function()
      vim.diagnostic.open_float(0, { scope = "line" })
    end,
    opts,
  }
  nnoremap {
    "]g",
    function()
      vim.diagnostic.goto_next { float = popup_opts }
    end,
    opts,
  }
  nnoremap {
    "[g",
    function()
      vim.diagnostic.goto_prev { float = popup_opts }
    end,
    opts,
  }

  nnoremap {
    "<C-s>",
    function()
      vim.lsp.buf.signature_help()
    end,
    opts,
  }
  inoremap {
    "<C-s>",
    function()
      vim.lsp.buf.signature_help()
    end,
    opts,
  }
  nnoremap {
    "K",
    function()
      vim.lsp.buf.hover()
    end,
    opts,
  }

  -- telescope
  nnoremap {
    "<Leader>ga",
    function()
      require("telescope.builtin").lsp_code_actions {}
    end,
    opts,
  }
  nnoremap {
    "<M-Enter>",
    function()
      require("telescope.builtin").lsp_code_actions {}
    end,
    opts,
  }
  nnoremap {
    "<Leader>gr",
    function()
      require("telescope.builtin").lsp_references {}
    end,
    opts,
  }
  nnoremap {
    "<Leader>lo",
    function()
      require("telescope.builtin").lsp_document_symbols {}
    end,
    opts,
  }
  nnoremap {
    "<Leader>ls",
    function()
      require("telescope.builtin").lsp_workspace_symbols {}
    end,
    opts,
  }
  nnoremap {
    "<Leader>lg",
    function()
      require("telescope.builtin").lsp_document_diagnostics {}
    end,
    opts,
  }

  -- Typescript utils
  nnoremap {
    "<Leader>af",
    function()
      vim.cmd [[TSLspFixCurrent]]
    end,
    opts,
  }
  nnoremap {
    "<Leader>ao",
    function()
      vim.cmd [[TSLspOrganize]]
    end,
    opts,
  }
  nnoremap {
    "<Leader>ai",
    function()
      vim.cmd [[TSLspImportCurrent]]
    end,
    opts,
  }
end

-- Attach handler. {{{2
function DoFormat()
  vim.lsp.buf.formatting_sync(nil, 3000)
  vim.api.nvim_command [[e]]
end

local attach_formatting = function()
  vim.api.nvim_command [[augroup Format]]
  vim.api.nvim_command [[autocmd! * <buffer>]]
  vim.api.nvim_command [[autocmd BufWritePost <buffer> lua DoFormat()]]
  vim.api.nvim_command [[augroup END]]
end

local custom_attach = function(client, bufnr)
  setup_key_mappings(bufnr)

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.resolved_capabilities.document_formatting then
    attach_formatting()
  end
end

-- Servers. {{{2

lspconfig.sumneko_lua.setup {
  cmd = require("lspcontainers").command "sumneko_lua",
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
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = custom_attach,
  capabilities = custom_capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
}

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,
  capabilities = custom_capabilities,
}

local ltex_path = vim.fn.stdpath "data" .. "/grammar-guard/ltex/bin/ltex-ls"
lspconfig.ltex.setup {
  cmd = { ltex_path },
  on_attach = custom_attach,
  capabilities = custom_capabilities,
  settings = {
    ltex = {
      disabledRules = { ["en-US"] = { "EN_QUOTES" } },
      additionalRules = { enablePickyRules = true },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = function(client)
    custom_attach(client)
    client.resolved_capabilities.document_formatting = false
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup()
    ts_utils.setup_client(client)
  end,
  capabilities = custom_capabilities,
  cmd = { "typescript-language-server", "--stdio" },
}

local dockerized_servers = {
  "bashls",
  "dockerls",
  "html",
  "jsonls",
  "pyright",
  "yamlls",
}

for _, server in pairs(dockerized_servers) do
  lspconfig[server].setup {
    before_init = function(params)
      params.processId = vim.NIL
    end,
    cmd = require("lspcontainers").command(server),
    root_dir = lspconfig.util.find_git_ancestor,
    on_attach = function(client)
      custom_attach(client)
    end,
    capabilities = custom_capabilities,
  }
end

-- Diagnostics. {{{3
lspconfig.diagnosticls.setup {
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
      javascript = { "tslint" },
      javascriptreact = { "tslint" },
      ["javascript.jsx"] = { "tslint" },
      typescript = { "tslint" },
      typescriptreact = { "tslint" },
      ["typescript.tsx"] = { "tslint" },
      css = "stylelint",
      scss = "stylelint",
      sass = "stylelint",
      less = "stylelint",
      markdown = "proselint",
      rst = "proselint",
    },
    linters = {
      tslint = {
        command = "./node_modules/.bin/tslint",
        rootPatterns = { ".git" },
        debounce = 100,
        args = { "%filepath", "--format", "json" },
        sourceName = "tslint",
        parseJson = {
          line = "startPosition.line",
          column = "startPosition.character",
          endLine = "endPosition.line",
          endColumn = "endPosition.character",
          message = "[tslint] ${failure} (${ruleName})",
          security = "ruleSeverity",
        },
      },
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
      tslintFix = {
        command = "./node_modules/.bin/tslint",
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
      javascript = { "tslintFix", "eslintFix" },
      javascriptreact = { "tslintFix", "eslintFix" },
      ["javascript.jsx"] = { "tslintFix", "eslintFix" },
      typescript = { "tslintFix", "eslintFix" },
      typescriptreact = { "tslintFix", "eslintFix" },
      ["typescript.tsx"] = { "tslintFix", "eslintFix" },
      css = "stylelintFix",
      scss = "stylelintFix",
      sass = "stylelintFix",
      less = "stylelintFix",
      lua = "styluaFix",
    },
  },
}

-- Servers with default setup. {{{3
local servers = { "vimls", "jdtls", "cssls", "eslint" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_attach,
    capabilities = custom_capabilities,
  }
end
