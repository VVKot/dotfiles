all: sync

sync:
	mkdir -p ~/.config/glow

	[ -f ~/.config/glow/glow.yml ] || ln -s $(PWD)/glow.yml ~/.config/glow/glow.yml
	[ -f ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -f ~/.digrc ] || ln -s $(PWD)/digrc ~/.digrc
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

sync-mac:
	mkdir -p ~/.iterm
	mkdir -p ~/Library/Preferences/glow

	[ -f ~/.iterm/com.googlecode.iterm2.plist ] || ln -s $(PWD)/iterm/com.googlecode.iterm2.plist ~/.iterm/com.googlecode.iterm2.plist
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json
	[ -f ~/Library/Preferences/glow/glow.yml ] || ln -s $(PWD)/glow.yml ~/Library/Preferences/glow/glow.yml

clean:
	unlink ~/.config/glow/glow.yml || true
	unlink ~/.config/starship.toml || true
	unlink ~/.digrc || true
	unlink ~/.ideavimrc || true
	unlink ~/.inputrc || true
	unlink ~/.iterm/com.googlecode.iterm2.plist || true
	unlink ~/.tmux.conf || true
	unlink ~/.zprofile || true
	unlink ~/.zshrc || true
	unlink ~/Library/Application\ Support/Code/User/settings.json || true
	unlink ~/Library/Preferences/glow/glow.yml || true
	unlink ~/.config/nvim || true

.PHONY: all clean sync sync-mac build run kill
