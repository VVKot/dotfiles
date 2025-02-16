all: sync

sync:
	[ -f ~/.digrc ] || ln -s $(PWD)/digrc ~/.digrc
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

sync-mac:
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	unlink ~/.digrc || true
	unlink ~/.ideavimrc || true
	unlink ~/.inputrc || true
	unlink ~/.zprofile || true
	unlink ~/.zshrc || true
	unlink ~/Library/Application\ Support/Code/User/settings.json || true

.PHONY: all clean sync sync-mac build run kill
