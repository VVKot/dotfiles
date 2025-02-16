all: sync

sync:
	mkdir -p ~/.config/k9s/skins

	[ -f ~/.config/k9s/config.yaml ] || ln -s $(PWD)/config/k9s/config.yaml ~/.config/k9s/config.yaml
	[ -f ~/.config/k9s/skins/transparent.yaml ] || ln -s $(PWD)/config/k9s/skins/transparent.yaml ~/.config/k9s/skins/transparent.yaml
	[ -e ~/.config/nix ] || ln -s $(PWD)/config/nix ~/.config/nix
	[ -e ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -e ~/.config/ghostty ] || ln -s $(PWD)/config/ghostty ~/.config/ghostty
	[ -e ~/.config/wezterm ] || ln -s $(PWD)/config/wezterm ~/.config/wezterm
	[ -f ~/.digrc ] || ln -s $(PWD)/digrc ~/.digrc
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc
	[ -f ~/.zprofile ] || ln -s $(PWD)/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

sync-mac:
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	unlink ~/.config/k9s/config.yaml || true
	unlink ~/.config/k9s/skins/transparent.yaml || true
	unlink ~/.config/starship.toml || true
	unlink ~/.digrc || true
	unlink ~/.ideavimrc || true
	unlink ~/.inputrc || true
	unlink ~/.zprofile || true
	unlink ~/.zshrc || true
	unlink ~/Library/Application\ Support/Code/User/settings.json || true
	unlink ~/.config/nix || true
	unlink ~/.config/nvim || true
	unlink ~/.config/ghostty || true
	unlink ~/.config/wezterm || true

.PHONY: all clean sync sync-mac build run kill
