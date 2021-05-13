require('el').reset_windows()

local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local lsp_statusline = require('el.plugins.lsp_status')

local file_icon = subscribe.buf_autocmd("el_file_icon", "BufNewFile,BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. ' '
  end

  return ''
end)

require('el').setup {
  generator = function(_, _)
    return {
      lsp_statusline.segment,
      lsp_statusline.server_progress,
      sections.split,
      file_icon,
      sections.maximum_width(
        builtin.responsive_file(100, 80),
        0.60
      ),
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
      sections.split,
      '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',
      builtin.filetype,
    }
  end
}
