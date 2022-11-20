all: sync

sync:
	[ -f ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.digrc ] || ln -s $(PWD)/digrc ~/.digrc
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

sync-mac:
	mkdir -p ~/.iterm

	[ -f ~/.iterm/com.googlecode.iterm2.plist ] || ln -s $(PWD)/iterm/com.googlecode.iterm2.plist ~/.iterm/com.googlecode.iterm2.plist
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	unlink ~/.digrc || true
	unlink ~/.ideavimrc || true
	unlink ~/.inputrc || true
	unlink ~/.iterm/com.googlecode.iterm2.plist || true
	unlink ~/.zprofile || true
	unlink ~/.zshrc || true
	unlink ~/Library/Application\ Support/Code/User/settings.json || true
	unlink ~/.config/nvim || true

.PHONY: all clean sync sync-mac build run kill
