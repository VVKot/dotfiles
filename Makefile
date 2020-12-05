all: sync

sync:
	mkdir -p ~/.config/bat
	mkdir -p ~/.config/coc/extensions
	mkdir -p ~/.gradle
	mkdir -p ~/.iterm
	mkdir -p ~/Library/Preferences/glow

	[ -f ~/.config/bat/config ] || ln -s $(PWD)/config/bat/config ~/.config/bat/config
	[ -f ~/.config/coc/extensions/package.json ] || ln -s $(PWD)/config/coc/extensions/package.json ~/.config/coc/extensions/package.json
	[ -f ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.gradle/gradle.properties ] || ln -s $(PWD)/.gradle/gradle.properties ~/.gradle/gradle.properties
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.iterm/com.googlecode.iterm2.plist ] || ln -s $(PWD)/iterm/com.googlecode.iterm2.plist ~/.iterm/com.googlecode.iterm2.plist
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json
	[ -f ~/Library/Preferences/glow/glow.yml ] || ln -s $(PWD)/glow.yml ~/Library/Preferences/glow/glow.yml

clean:
	rm -f ~/.config/bat/config
	rm -f ~/.config/coc/extensions/package.json
	rm -f ~/.gradle/gradle.properties
	rm -f ~/.ideavimrc
	rm -f ~/.inputrc
	rm -f ~/.iterm/com.googlecode.iterm2.plist
	rm -f ~/.tmux.conf
	rm -f ~/.zprofile
	rm -f ~/.zshrc
	rm -f ~/Library/Application\ Support/Code/User/settings.json
	rm -f ~/Library/Preferences/glow/glow.yml
	rm -rf ~/.config/nvim

.PHONY: all clean sync build run kill
