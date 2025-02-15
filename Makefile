all: sync

sync:
	mkdir -p ~/.config/k9s/skins

	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/non-nix/config.fish ~/.config/fish/config.fish
	[ -e ~/.config/ghostty ] || ln -s $(PWD)/config/ghostty ~/.config/ghostty
	[ -f ~/.config/ideavim/ideavimrc ] || ln -s $(PWD)/config/ideavim/ideavimrc ~/.config/ideavim/ideavimrc
	[ -f ~/.config/k9s/config.yaml ] || ln -s $(PWD)/config/k9s/config.yaml ~/.config/k9s/config.yaml
	[ -f ~/.config/k9s/skins/transparent.yaml ] || ln -s $(PWD)/config/k9s/skins/transparent.yaml ~/.config/k9s/skins/transparent.yaml
	[ -e ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/non-nix/tmux.conf ~/.tmux.conf

sync-mac:
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/non-nix/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean:
	unlink ~/.config/fish/config.fish || true
	unlink ~/.config/ghostty || true
	unlink ~/.config/ideavim/ideavimrc || true
	unlink ~/.config/k9s/config.yaml || true
	unlink ~/.config/k9s/skins/transparent.yaml || true
	unlink ~/.config/nvim || true
	unlink ~/.config/starship.toml || true
	unlink ~/.tmux.conf || true
	unlink ~/Library/Application\ Support/Code/User/settings.json || true

.PHONY: all clean sync sync-mac build run kill
