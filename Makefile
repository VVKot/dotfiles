all: sync

sync:
	mkdir -p ~/.config/bat
	mkdir -p ~/.config/glow
	mkdir -p ~/.config/kitty
	mkdir -p ~/.gradle
	mkdir -p ~/Library/Preferences/glow

	[ -f ~/.config/bat/config ] || ln -s $(PWD)/config/bat/config ~/.config/bat/config
	[ -f ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -f ~/.gradle/gradle.properties ] || ln -s $(PWD)/.gradle/gradle.properties ~/.gradle/gradle.properties
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/Library/Preferences/glow/glow.yml ] || ln -s $(PWD)/glow.yml ~/Library/Preferences/glow/glow.yml
	[ -f ~/.config/glow/glow.yml ] || ln -s $(PWD)/glow.yml ~/.config/glow/glow.yml
	[ -f ~/.config/kitty/kitty.conf ] || ln -s $(PWD)/config/kitty/kitty.conf ~/.config/kitty/kitty.conf

sync-mac:
	mkdir -p ~/.iterm

	[ -f ~/.iterm/com.googlecode.iterm2.plist ] || ln -s $(PWD)/iterm/com.googlecode.iterm2.plist ~/.iterm/com.googlecode.iterm2.plist
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	rm -f ~/.config/starship.toml || true
	rm -f ~/.gradle/gradle.properties || true
	rm -f ~/.ideavimrc || true
	rm -f ~/.inputrc || true
	rm -f ~/.iterm/com.googlecode.iterm2.plist || true
	rm -f ~/.tmux.conf || true
	rm -f ~/.zprofile || true
	rm -f ~/.zshrc || true
	rm -f ~/Library/Application\ Support/Code/User/settings.json || true
	rm -f ~/Library/Preferences/glow/glow.yml || true
	rm -f ~/.config/glow/glow.yml || true
	rm -f ~/.config/kitty/kitty.conf || true
	rm -rf ~/.config/nvim || true

.PHONY: all clean sync sync-mac build run kill
