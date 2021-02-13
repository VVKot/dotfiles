source ~/.config/nvim/common.vim

lua require "vkot/install_packer"
lua require "vkot/all_plugins"

source ~/.config/nvim/settings.plugins.vim

if filereadable(expand("~/.config/nvim/extra.vim"))
  source ~/.config/nvim/extra.vim
endif

if !exists('g:vscode')
  lua require "init"
endif

" Show comments in italics.
highlight Comment cterm=italic gui=italic
