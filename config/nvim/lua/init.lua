-- LSP. {{{1
local lsp = require("nvim_lsp")
local completion = require("completion")
local lsp_status = require("lsp-status")

-- LSP status. {{{2
lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = '❌',
  indicator_warnings = '⚠️ ',
  indicator_info = 'ℹ️',
  indicator_hint = '💡',
  indicator_ok = '✔️',
  kind_labels = vim.g.completion_customize_lsp_label,
})

-- Helper functions. {{{2
local map_key = function(bufnr, mode, key, command, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
end

local nnoremap = function(bufnr, key, command)
  local opts = { noremap = true, silent = true }
  map_key(bufnr, 'n', key, command, opts)
end

local inoremap = function(bufnr, key, command)
  local opts = { noremap = true, silent = true }
  map_key(bufnr, 'i', key, command, opts)
end

local imap = function(bufnr, key, command)
  local opts = { noremap = false, silent = true }
  map_key(bufnr, 'i', key, command, opts)
end

-- Key maps. {{{2
local setup_key_mappings = function(bufnr)
  nnoremap(bufnr, '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap(bufnr, '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap(bufnr, '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nnoremap(bufnr, '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  nnoremap(bufnr, '<Leader>gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  nnoremap(bufnr, '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  nnoremap(bufnr, '<Leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  nnoremap(bufnr, '<Leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  nnoremap(bufnr, '<Leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')

  nnoremap(bufnr, '<Leader>lo', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  nnoremap(bufnr, '<Leader>ls', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  nnoremap(bufnr, '<Leader>lg', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  nnoremap(bufnr, ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  nnoremap(bufnr, '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

  imap(bufnr, '<C-Space>', '<Plug>(completion_trigger)')
  inoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nnoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
end

-- Attach handler. {{{2
local custom_attach = function(client, bufnr)
  print("LSP started.")
  completion.on_attach()

  lsp_status.on_attach(client)
  vim.cmd [[augroup update_lsp_status_function]]
  vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
  vim.cmd [[augroup END]]

  setup_key_mappings(bufnr)
  print("LSP attached.")
end

-- Servers. {{{2

lsp.sumneko_lua.setup{
  on_attach = custom_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    Lua = {
      diagnostics = {enable = true, globals = {"vim"}}
    }
  },
}

lsp.gopls.setup{
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

local servers = { 'vimls', 'dockerls', 'bashls', 'jdtls' }

for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
}
end

-- Treesitter. {{{1
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
}

-- Tree. {{{1
local settings = vim.g
local dummy_binding = "<Leader>000" -- need to fix upstream

settings.lua_tree_width = 60
settings.lua_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
}
settings.lua_tree_bindings = {
  edit = { '<CR>', 'i' },
  edit_vsplit = 'a',
  edit_split = 'o',
  refresh = 'R',
  preview = 'p',

  edit_tab = dummy_binding,
  toggle_ignored = dummy_binding,
  toggle_dotfiles = dummy_binding,
  cd = dummy_binding,
  create = dummy_binding,
  remove = dummy_binding,
  rename = dummy_binding,
  cut = dummy_binding,
  copy = dummy_binding,
  paste = dummy_binding,
  prev_git_item = dummy_binding,
  next_git_item = dummy_binding,
}
