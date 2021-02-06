vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_customize_lsp_label = {
  Function = " [function]",
  Method = " [method]",
  Reference = " [reference]",
  Enum = " [enum]",
  Field = "ﰠ [field]",
  Keyword = " [key]",
  Variable = " [variable]",
  Folder = " [folder]",
  Snippet = " [snippet]",
  Operator = " [operator]",
  Module = " [module]",
  Text = "ﮜ [text]",
  Class = " [class]",
  Interface = " [interface]"
}

local lspconfig = require("lspconfig")
local completion = require("completion")
local lsp_status = require("lsp-status")

-- LSP status. {{{2
lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  current_function = false,
  indicator_errors = '❌',
  indicator_warnings = '⚠️ ',
  indicator_info = 'ℹ️',
  indicator_hint = '💡',
  indicator_ok = '✔️',
  kind_labels = vim.g.completion_customize_lsp_label,
})

-- Helper functions. {{{2
local buf_map_key = function(bufnr, mode, key, command, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
end

local map_key = function(mode, key, command, opts)
  vim.api.nvim_set_keymap(mode, key, command, opts)
end

local buf_nnoremap = function(bufnr, key, command)
  local opts = { noremap = true, silent = true }
  buf_map_key(bufnr, 'n', key, command, opts)
end

local nnoremap = function(key, command)
  local opts = { noremap = true, silent = true }
  map_key('n', key, command, opts)
end

local buf_inoremap = function(bufnr, key, command)
  local opts = { noremap = true, silent = true }
  buf_map_key(bufnr, 'i', key, command, opts)
end

local buf_imap = function(bufnr, key, command)
  local opts = { noremap = false, silent = true }
  buf_map_key(bufnr, 'i', key, command, opts)
end

-- Key maps. {{{2
local setup_key_mappings = function(bufnr)
  -- references
  buf_nnoremap(bufnr, '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_nnoremap(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_nnoremap(bufnr, '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_nnoremap(bufnr, 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_nnoremap(bufnr, '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_nnoremap(bufnr, '<Leader>gR', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_nnoremap(bufnr, '<Leader>gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_nnoremap(bufnr, '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  -- actions
  buf_nnoremap(bufnr, '<Leader>gA', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_nnoremap(bufnr, '<Leader>gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  buf_nnoremap(bufnr, '<Leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')

  -- lists
  buf_nnoremap(bufnr, '<Leader>lO', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  buf_nnoremap(bufnr, '<Leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  buf_nnoremap(bufnr, '<Leader>lg', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  buf_nnoremap(bufnr, ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  buf_nnoremap(bufnr, '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

  -- completion
  buf_imap(bufnr, '<C-Space>', '<Plug>(completion_trigger)')
  buf_imap(bufnr, '<Tab>', '<Plug>(completion_smart_tab)')
  buf_imap(bufnr, '<S-Tab>', '<Plug>(completion_smart_s_tab)')
  buf_inoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_nnoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  -- telescope
  buf_nnoremap(bufnr, '<Leader><C-t>', '<cmd>lua require"telescope.builtin".find_files{}<CR>')
  buf_nnoremap(bufnr, '<Leader>ga', '<cmd>lua require"telescope.builtin".lsp_code_actions(require("telescope.themes").get_dropdown({winblend=10}))<CR>')
  buf_nnoremap(bufnr, '<M-Enter>', '<cmd>lua require"telescope.builtin".lsp_code_actions(require("telescope.themes").get_dropdown({winblend=10}))<CR>')
  buf_nnoremap(bufnr, '<Leader>gr', '<cmd>lua require"telescope.builtin".lsp_references{}<CR>')
  buf_nnoremap(bufnr, '<Leader>lo', '<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>')
  buf_nnoremap(bufnr, '<Leader>ls', '<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>')
end

-- Attach handler. {{{2
function DoFormat()
  vim.lsp.buf.formatting_sync(nil, 3000)
  vim.api.nvim_command [[e]]
end

local attach_formatting = function(client)
  vim.api.nvim_command [[augroup Format]]
  vim.api.nvim_command [[autocmd! * <buffer>]]
  vim.api.nvim_command [[autocmd BufWritePost <buffer> lua DoFormat()]]
  vim.api.nvim_command [[augroup END]]

  print(string.format('%s formatting attached', client.name))
end

local custom_attach = function(client, bufnr)
  print("LSP started.")
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
  completion.on_attach()
  lsp_status.on_attach(client)
  setup_key_mappings(bufnr)

  if client.resolved_capabilities.document_formatting then
    print(string.format("%s formatting supported", client.name))

    attach_formatting(client)
  end

  print("LSP attached.")
end

-- Servers. {{{2

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = custom_attach,
  capabilities = lsp_status.capabilities,
  settings = {
      Lua = {
          runtime = {
              -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
                enable = true,
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
          },
          workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}

lspconfig.gopls.setup{
  on_attach = custom_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    }
  },
}

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,

  -- Required for lsp-status
  handlers = lsp_status.extensions.clangd.setup(),
  capabilities = lsp_status.capabilities,
})

-- Diagnostics. {{{3
lspconfig.diagnosticls.setup {
  on_attach = custom_attach,
  capabilities = lsp_status.capabilities,
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
  },
  init_options = {
    filetypes = {
      javascript = {"eslint", "tslint"},
      javascriptreact = {"eslint", "tslint"},
      ["javascript.jsx"] = {"eslint", "tslint"},
      typescript = {"eslint", "tslint"},
      typescriptreact = {"eslint", "tslint"},
      ["typescript.tsx"] = {"eslint", "tslint"},
      css = "stylelint",
      scss = "stylelint",
      sass = "stylelint",
      less = "stylelint",
    },
    linters = {
      eslint = {
        command = "./node_modules/.bin/eslint",
        rootPatterns = {".git"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        sourceName = "eslint",
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "[eslint] ${message} (${ruleId})",
          security = "severity",
        },
        securities = {[2] = "error", [1] = "warning"},
      },
      tslint = {
        command = "./node_modules/.bin/tslint",
        rootPatterns = {".git"},
        debounce = 100,
        args = {"%filepath", "--format", "json"},
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
        rootPatterns = {".git"},
        debounce = 100,
        args = {"%filepath", "--formatter", "json"},
        sourceName = "stylelint",
        parseJson = {
          errorsRoot = "[0].warnings",
          line = "line",
          column = "column",
          message = "[stylelint] ${text}",
          security = "severity",
        },
      },
    },
    formatters = {
      eslintFix = {
        command = "./node_modules/.bin/eslint",
        args = {"%filepath", "--fix" },
        rootPatterns = {".git"},
      },
      tslintFix = {
        command = "./node_modules/.bin/tslint",
        args = {"%filepath", "--fix" },
        rootPatterns = {".git"},
      },
      stylelintFix = {
        command = "./node_modules/.bin/stylelint",
        args = {"%filepath", "--fix" },
        rootPatterns = {".git"},
      },
    },
    formatFiletypes = {
      javascript = {"tslintFix", "eslintFix"},
      javascriptreact = {"tslintFix", "eslintFix"},
      ["javascript.jsx"] = {"tslintFix", "eslintFix"},
      typescript = {"tslintFix", "eslintFix"},
      typescriptreact = {"tslintFix", "eslintFix"},
      ["typescript.tsx"] = {"tslintFix", "eslintFix"},
      css = "stylelintFix",
      scss = "stylelintFix",
      sass = "stylelintFix",
      less = "stylelintFix",
    },
  }
}

-- Servers with default setup. {{{3
local servers = { 'vimls', 'dockerls', 'bashls', 'jdtls', 'cssls', 'html', 'tsserver' }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
}
end


-- Other keymaps. {{{1
nnoremap('<Leader>tt', '<cmd>lua require("telescope.builtin").git_files{show_untracked=false}<CR>')
nnoremap('<Leader>ft', '<cmd>lua require("telescope.builtin").grep_string { search = vim.fn.input(":RG "), }<CR>')
nnoremap('<Leader>gt', '<cmd>lua require("telescope.builtin").git_status{}<CR>')
