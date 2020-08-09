all: sync

sync:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/bat

	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
	[ -f ~/.config/nvim/coc-settings.json ] || ln -s $(PWD)/vim/coc-settings.json ~/.config/nvim/coc-settings.json
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.mini.vimrc ] || ln -s $(PWD)/mini.vimrc ~/.mini.vimrc
	[ -f ~/.vim/coc-settings.json ] || ln -s $(PWD)/vim/coc-settings.json ~/.vim/coc-settings.json
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.config/bat/config ] || ln -s $(PWD)/bat.config ~/.config/bat/config

clean:
	rm -f ~/.config/nvim/init.vim 
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.vimrc 
	rm -f ~/.mini.vimrc
	rm -f ~/.vim/coc-settings.json
	rm -f ~/.tmux.conf
	rm -f ~/.ideavimrc
	rm -f ~/.inputrc
	rm -f ~/.zshrc
	rm -f ~/.config/bat/config

.PHONY: all clean sync build run kill
