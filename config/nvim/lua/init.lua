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
  -- references
  nnoremap(bufnr, '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap(bufnr, '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap(bufnr, '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nnoremap(bufnr, '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  nnoremap(bufnr, '<Leader>gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  nnoremap(bufnr, '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  -- actions
  nnoremap(bufnr, '<M-Enter>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  nnoremap(bufnr, '<Leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  nnoremap(bufnr, '<Leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  nnoremap(bufnr, '<Leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')

  -- lists
  nnoremap(bufnr, '<Leader>lo', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  nnoremap(bufnr, '<Leader>ls', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  nnoremap(bufnr, '<Leader>lg', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  nnoremap(bufnr, ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  nnoremap(bufnr, '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

  -- completion
  imap(bufnr, '<C-Space>', '<Plug>(completion_trigger)')
  inoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nnoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  -- telescope
  nnoremap(bufnr, '<Leader><Leader>', '<cmd>lua require"telescope.builtin".git_files{}<CR>')
  nnoremap(bufnr, '<Leader><C-t>', '<cmd>lua require"telescope.builtin".find_files{}<CR>')
  nnoremap(bufnr, '<Leader>gA', '<cmd>lua require"telescope.builtin".lsp_code_actions{}<CR>')
  nnoremap(bufnr, '<Leader>gR', '<cmd>lua require"telescope.builtin".lsp_references{}<CR>')
  nnoremap(bufnr, '<Leader>lO', '<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>')
  nnoremap(bufnr, '<Leader>lS', '<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>')
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

-- Telescope. {{{1
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_mappings = {
  ["j"] = false,
  ["k"] = false,
  ["<C-j>"] = telescope_actions.move_selection_next,
  ["<C-k>"] = telescope_actions.move_selection_previous,
  ["<esc>"] = telescope_actions.close,
}

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
    prompt_prefix = "🔭",
    mappings = {
      i = telescope_mappings,
      n = telescope_mappings,
    },
  }

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

-- Statusline. {{{1
require('el').reset_windows()

local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local lsp_statusline = require('el.plugins.lsp_status')

local maybe_coc_status = subscribe.buf_autocmd("el_coc_status", "BufRead,CursorHold", function(_, buffer)
  if buffer.lsp then
    return ''
  end
  return vim.fn['coc#status']()
end)

local lsp_segment = subscribe.buf_autocmd("el_lsp_segment", "CursorHold", function(_, buffer)
  if buffer.lsp == false then
    return ''
  end
  local status = lsp_status.status()
  -- strip the current function
  if status and status[0] == '(' then
    return string.match(status, "%)(.*)")
  end
  return status
end)

local file_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. ' '
  end

  return ''
end)

require('el').setup {
  generator = function(_, _)
    return {
      maybe_coc_status,
      lsp_segment,
      lsp_statusline.server_progress,
      sections.split,
      file_icon,
      sections.maximum_width(
        builtin.responsive_file(140, 90),
        0.30
      ),
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
      sections.split,
      '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',
      sections.collapse_builtin {
        '[',
        builtin.help_list,
        builtin.readonly_list,
        ']',
      },
      builtin.filetype,
    }
  end
}
