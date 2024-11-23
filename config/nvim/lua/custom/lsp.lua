local M = {}

M.setup = function()
  vim.opt.listchars = { tab = "⇥ ", leadmultispace = "┊ ", trail = "␣", nbsp = "⍽" }
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.inlay_hint.enable()

  local lspconfig = require("lspconfig")

  -- Key maps. {{{2

  -- diagnostics

  vim.keymap.set("n", "<Leader>ld", vim.diagnostic.setloclist)

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
      vim.keymap.set({ "n", "i" }, "<C-S>", vim.lsp.buf.signature_help, opts)

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

  lspconfig.ruff.setup({
    init_options = {
      settings = {
        args = { "--preview" },
      },
    },
  })

  lspconfig.pyright.setup({})
  lspconfig.rust_analyzer.setup({})
  lspconfig.yamlls.setup({})
  lspconfig.helm_ls.setup({})

  if os.getenv("JDTLS_ENABLED") == "1" then
    lspconfig.jdtls.setup({
      use_lombok_agent = true,
      settings = {
        java = {
          jdt = {
            ls = {
              vmargs = "-noverify -Xmx8G -XX:+UseG1GC -XX:+UseStringDeduplication",
              lombokSupport = {
                enabled = true,
              },
            },
          },
          autobuild = {
            enabled = false,
          },
          format = {
            enabled = false,
          },
          eclipse = {
            downloadSources = true,
          },
          maven = {
            downloadSources = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          implementationsCodeLens = {
            enabled = false,
          },
          referenceCodeLens = {
            enabled = false,
          },
          inlayHints = {
            parameterNames = {
              enabled = "none",
            },
          },
          signatureHelp = {
            enabled = true,
            description = {
              enabled = true,
            },
          },
        },
        redhat = { telemetry = { enabled = false } },
      },
    })
  end
end

return M
