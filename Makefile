all: sync

sync:
	mkdir -p ~/.config/bat
	mkdir -p ~/.config/glow

	[ -f ~/.config/bat/config ] || ln -s $(PWD)/config/bat/config ~/.config/bat/config
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
	rm -f ~/.config/bat/config || true
	rm -f ~/.config/glow/glow.yml || true
	rm -f ~/.config/starship.toml || true
	rm -f ~/.digrc || true
	rm -f ~/.ideavimrc || true
	rm -f ~/.inputrc || true
	rm -f ~/.iterm/com.googlecode.iterm2.plist || true
	rm -f ~/.tmux.conf || true
	rm -f ~/.zprofile || true
	rm -f ~/.zshrc || true
	rm -f ~/Library/Application\ Support/Code/User/settings.json || true
	rm -f ~/Library/Preferences/glow/glow.yml || true
	rm -rf ~/.config/nvim || true

.PHONY: all clean sync sync-mac build run kill
