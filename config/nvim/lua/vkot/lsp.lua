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
  buf_nnoremap(bufnr, '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_nnoremap(bufnr, '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_nnoremap(bufnr, '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_nnoremap(bufnr, '<Leader>gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_nnoremap(bufnr, '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  -- actions
  buf_nnoremap(bufnr, '<M-Enter>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_nnoremap(bufnr, '<Leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_nnoremap(bufnr, '<Leader>gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  buf_nnoremap(bufnr, '<Leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')

  -- lists
  buf_nnoremap(bufnr, '<Leader>lo', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  buf_nnoremap(bufnr, '<Leader>ls', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  buf_nnoremap(bufnr, '<Leader>lg', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  buf_nnoremap(bufnr, ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  buf_nnoremap(bufnr, '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

  -- completion
  buf_imap(bufnr, '<C-Space>', '<Plug>(completion_trigger)')
  buf_inoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_nnoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  -- telescope
  buf_nnoremap(bufnr, '<Leader><Leader>', '<cmd>lua require"telescope.builtin".git_files{show_untracked=false}<CR>')
  buf_nnoremap(bufnr, '<Leader><C-t>', '<cmd>lua require"telescope.builtin".find_files{}<CR>')
  buf_nnoremap(bufnr, '<Leader>gA', '<cmd>lua require"telescope.builtin".lsp_code_actions{}<CR>')
  buf_nnoremap(bufnr, '<Leader>gR', '<cmd>lua require"telescope.builtin".lsp_references{}<CR>')
  buf_nnoremap(bufnr, '<Leader>lO', '<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>')
  buf_nnoremap(bufnr, '<Leader>lS', '<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>')
end

-- Attach handler. {{{2
local custom_attach = function(client, bufnr)
  print("LSP started.")
  completion.on_attach()
  lsp_status.on_attach(client)
  setup_key_mappings(bufnr)
  print("LSP attached.")
end

-- Servers. {{{2

lspconfig.sumneko_lua.setup{
  on_attach = custom_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    Lua = {
      diagnostics = {enable = true, globals = {"vim"}}
    }
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

local servers = { 'vimls', 'dockerls', 'bashls', 'jdtls' }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
}
end

-- Other keymaps. {{{1
nnoremap('<Leader>fp', '<cmd>lua require("telescope.builtin").grep_string { search = vim.fn.input(":RG "), }<CR>')
