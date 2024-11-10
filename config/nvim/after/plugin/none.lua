local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.code_actions.impl,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.ts_node_action,
    null_ls.builtins.completion.spell,

    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.hover.printenv,
  },
})
