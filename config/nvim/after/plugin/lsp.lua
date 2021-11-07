local popup_opts = {border = "single"}
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, popup_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {signs = false, virtual_text = false})

local peek_definition = function()
    vim.lsp.buf_request(0, "textDocument/definition",
                        vim.lsp.util.make_position_params(),
                        function(_, _, result)
        if result == nil or vim.tbl_isempty(result) then return nil end
        vim.lsp.util.preview_location(result[1], popup_opts)
    end)
end

local nnoremap = vim.keymap.nnoremap
nnoremap {"<Leader>gh", peek_definition}

local lspkind = require("lspkind")
lspkind.init()

local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = vim.tbl_extend("keep", custom_capabilities or {},
                                     lsp_status.capabilities)
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}
custom_capabilities = require('cmp_nvim_lsp').update_capabilities(
                          custom_capabilities)

local cmp = require("cmp")
cmp.setup {
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<C-space>"] = cmp.mapping.complete()
    },
    sources = {
        {name = "nvim_lua"}, {name = "nvim_lsp"}, {name = "path"},
        {name = "ultisnips"},
        {name = "buffer", keyword_length = 5, max_item_count = 5}
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                nvim_lua = "[api]",
                nvim_lsp = "[LSP]",
                path = "[path]",
                ultisnips = "[snip]",
                buffer = "[buf]"
            }
        }
    },
    experimental = {native_menu = false, ghost_text = false}
}

-- LSP status. {{{2
lsp_status.register_progress()
lsp_status.config({
    status_symbol = '',
    current_function = false,
    indicator_errors = '❌',
    indicator_warnings = '⚠️ ',
    indicator_info = 'ℹ️',
    indicator_hint = '💡',
    indicator_ok = '',
    kind_labels = vim.g.completion_customize_lsp_label
})

-- Helper functions. {{{2
local buf_map_key = function(bufnr, mode, key, command, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
end

local buf_nnoremap = function(bufnr, key, command)
    local opts = {noremap = true, silent = true}
    buf_map_key(bufnr, 'n', key, command, opts)
end

local buf_vnoremap = function(bufnr, key, command)
    local opts = {noremap = true, silent = true}
    buf_map_key(bufnr, 'v', key, command, opts)
end

local buf_inoremap = function(bufnr, key, command)
    local opts = {noremap = true, silent = true}
    buf_map_key(bufnr, 'i', key, command, opts)
end

-- Key maps. {{{2
local setup_key_mappings = function(bufnr)
    -- references
    buf_nnoremap(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_nnoremap(bufnr, '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_nnoremap(bufnr, 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_nnoremap(bufnr, '<Leader>gi',
                 '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_nnoremap(bufnr, '<Leader>gR', '<cmd>lua vim.lsp.buf.references()<CR>')
    buf_nnoremap(bufnr, '<Leader>gy',
                 '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    buf_nnoremap(bufnr, '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

    -- actions
    buf_nnoremap(bufnr, '<Leader>gA', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_vnoremap(bufnr, '<Leader>gA',
                 '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    buf_nnoremap(bufnr, '<Leader>gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    buf_nnoremap(bufnr, '<Leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- lists
    buf_nnoremap(bufnr, '<Leader>lO',
                 '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    buf_nnoremap(bufnr, '<Leader>lS',
                 '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    buf_nnoremap(bufnr, '<Leader>lG',
                 '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    nnoremap {
        "<C-Space>",
        function() vim.diagnostic.open_float(0, {scope = "line"}) end,
        buffer = bufnr
    }
    nnoremap {
        "]g",
        function() vim.diagnostic.goto_next {float = {border = "single"}} end,
        buffer = bufnr
    }
    nnoremap {
        "[g",
        function() vim.diagnostic.goto_prev {float = {border = "single"}} end,
        buffer = bufnr
    }

    -- Light bulb for actions.
    -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    buf_inoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_nnoremap(bufnr, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

    -- telescope
    buf_nnoremap(bufnr, '<Leader>ga',
                 '<cmd>lua require"telescope.builtin".lsp_code_actions{}<CR>')
    buf_nnoremap(bufnr, '<M-Enter>',
                 '<cmd>lua require"telescope.builtin".lsp_code_actions{}<CR>')
    buf_vnoremap(bufnr, '<Leader>ga',
                 '<cmd>lua require"telescope.builtin".lsp_range_code_actions{}<CR>')
    buf_vnoremap(bufnr, '<M-Enter>',
                 '<cmd>lua require"telescope.builtin".lsp_range_code_actions{}<CR>')
    buf_nnoremap(bufnr, '<Leader>gr',
                 '<cmd>lua require"telescope.builtin".lsp_references{}<CR>')
    buf_nnoremap(bufnr, '<Leader>lo',
                 '<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>')
    buf_nnoremap(bufnr, '<Leader>ls',
                 '<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>')
    buf_nnoremap(bufnr, '<Leader>lg',
                 '<cmd>lua require"telescope.builtin".lsp_document_diagnostics{}<CR>')

    -- Typescript utils
    buf_nnoremap(bufnr, '<Leader>af', ':TSLspFixCurrent<CR>')
    buf_nnoremap(bufnr, '<Leader>ao', ':TSLspOrganize<CR>')
    buf_nnoremap(bufnr, '<Leader>ai', ':TSLspImportAll<CR>')
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

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
    lsp_status.on_attach(client)
    setup_key_mappings(bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    if client.resolved_capabilities.document_formatting then
        attach_formatting()
    end
end

-- Servers. {{{2

lspconfig.sumneko_lua.setup {
    cmd = require'lspcontainers'.command('sumneko_lua'),
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                enable = true,
                -- Get the language server to recognize the `vim` global
                globals = {"vim", "describe", "it", "before_each", "after_each"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}

lspconfig.gopls.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
    settings = {
        gopls = {
            usePlaceholders = true,
            analyses = {unusedparams = true},
            staticcheck = true
        }
    }
}

lspconfig.clangd.setup({
    cmd = {
        "clangd", "--background-index", "--suggest-missing-includes",
        "--clang-tidy", "--header-insertion=iwyu"
    },
    on_init = custom_init,
    on_attach = custom_attach,

    -- Required for lsp-status
    handlers = lsp_status.extensions.clangd.setup(),
    capabilities = custom_capabilities
})

local ltex_path = vim.fn.stdpath("data") .. "/grammar-guard/ltex/bin/ltex-ls";
lspconfig.ltex.setup {
    cmd = {ltex_path},
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
    settings = {ltex = {additionalRules = {enablePickyRules = true}}}
}

lspconfig.tsserver.setup {
    on_init = custom_init,
    on_attach = function(client)
        custom_attach(client)
        client.resolved_capabilities.document_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true
        }
        ts_utils.setup_client(client)
    end,
    capabilities = custom_capabilities,
    cmd = {"typescript-language-server", "--stdio"}
}

local dockerized_servers = {
    "bashls", "dockerls", "html", "jsonls", "pyright", "yamlls"
}

for _, server in pairs(dockerized_servers) do
    lspconfig[server].setup {
        before_init = function(params) params.processId = vim.NIL end,
        cmd = require'lspcontainers'.command(server),
        root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
        on_init = custom_init,
        on_attach = function(client) custom_attach(client) end,
        capabilities = custom_capabilities
    }
end

-- Diagnostics. {{{3
lspconfig.diagnosticls.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx", "css", "scss", "sass", "less",
        "lua", "markdown"
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
            markdown = "proselint"
        },
        linters = {
            eslint = {
                command = "./node_modules/.bin/eslint",
                rootPatterns = {".git"},
                debounce = 100,
                args = {
                    "--stdin", "--stdin-filename", "%filepath", "--format",
                    "json"
                },
                sourceName = "eslint",
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "[eslint] ${message} (${ruleId})",
                    security = "severity"
                },
                securities = {[2] = "error", [1] = "warning"}
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
                    security = "ruleSeverity"
                }
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
                    security = "severity"
                }
            },
            proselint = {
                command = 'proselint',
                debounce = 300,
                args = {'-j', "%filepath"},
                sourceName = 'proselint',
                parseJson = {
                    errorsRoot = 'data.errors',
                    line = 'line',
                    column = 'column',
                    message = '[proselint] ${message} (${check})',
                    security = 'severity'
                },
                securities = {
                    error = 'error',
                    warning = 'warning',
                    info = 'suggestion'
                }
            }
        },
        formatters = {
            eslintFix = {
                command = "./node_modules/.bin/eslint",
                args = {"%filepath", "--fix"},
                rootPatterns = {".git"}
            },
            tslintFix = {
                command = "./node_modules/.bin/tslint",
                args = {"%filepath", "--fix"},
                rootPatterns = {".git"}
            },
            stylelintFix = {
                command = "./node_modules/.bin/stylelint",
                args = {"%filepath", "--fix"},
                rootPatterns = {".git"}
            },
            luaformatFix = {
                command = "lua-format",
                args = {"-i", "%filepath"},
                rootPatterns = {".git"}
            }
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
            lua = "luaformatFix"
        }
    }
}

-- Servers with default setup. {{{3
local servers = {'vimls', 'jdtls', 'cssls', 'eslint'}

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = custom_capabilities
    }
end

