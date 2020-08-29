all: sync

sync:
	mkdir -p ~/.config/bat
	mkdir -p ~/.config/coc/extensions
	mkdir -p ~/.config/nvim
	mkdir -p ~/.gradle
	mkdir -p ~/.iterm

	[ -f ~/.config/bat/config ] || ln -s $(PWD)/.config/bat/config ~/.config/bat/config
	[ -f ~/.config/coc/extensions/package.json ] || ln -s $(PWD)/.config/coc/extensions/package.json ~/.config/coc/extensions/package.json
	[ -f ~/.config/nvim/coc-settings.json ] || ln -s $(PWD)/vim/coc-settings.json ~/.config/nvim/coc-settings.json
	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/.config/nvim/init.vim ~/.config/nvim/init.vim
	[ -f ~/.config/nvim/mini.init.vim ] || ln -s $(PWD)/.config/nvim/mini.init.vim ~/.config/nvim/mini.init.vim
	[ -f ~/.gradle/gradle.properties ] || ln -s $(PWD)/.gradle/gradle.properties ~/.gradle/gradle.properties
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.iterm/com.googlecode.iterm2.plist ] || ln -s $(PWD)/iterm/com.googlecode.iterm2.plist ~/.iterm/com.googlecode.iterm2.plist
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	rm -f ~/.config/bat/config
	rm -f ~/.config/coc/extensions/package.json
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.config/nvim/init.vim 
	rm -f ~/.config/nvim/mini.init.vim
	rm -f ~/.gradle/gradle.properties
	rm -f ~/.ideavimrc
	rm -f ~/.inputrc
	rm -f ~/.iterm/com.googlecode.iterm2.plist
	rm -f ~/.tmux.conf
	rm -f ~/.zprofile
	rm -f ~/.zshrc
	rm -f ~/Library/Application\ Support/Code/User/settings.json

.PHONY: all clean sync build run kill
