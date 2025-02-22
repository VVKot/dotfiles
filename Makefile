all: sync-mac

sync-linux:
	mkdir -p ~/.config/k9s/skins

	[ -e ~/.config/ghostty ] || ln -s $(PWD)/config/ghostty ~/.config/ghostty
	[ -e ~/.config/ideavim ] || ln -s $(PWD)/config/ideavim ~/.config/ideavim
	[ -f ~/.config/k9s/config.yaml ] || ln -s $(PWD)/config/k9s/config.yaml ~/.config/k9s/config.yaml
	[ -f ~/.config/k9s/skins/transparent.yaml ] || ln -s $(PWD)/config/k9s/skins/transparent.yaml ~/.config/k9s/skins/transparent.yaml
	[ -e ~/.config/nvim ] || ln -s $(PWD)/config/nvim ~/.config/nvim
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/config/starship.toml ~/.config/starship.toml
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/non-nix/tmux.conf ~/.tmux.conf
	[ -f ~/.zprofile ] || ln -s $(PWD)/non-nix/zprofile ~/.zprofile
	[ -f ~/.zshrc ] || ln -s $(PWD)/non-nix/zshrc ~/.zshrc

sync-mac:
	[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s $(PWD)/non-nix/settings.json ~/Library/Application\ Support/Code/User/settings.json

clean-linux:
	unlink ~/.config/ghostty || true
	unlink ~/.config/ideavim || true
	unlink ~/.config/k9s/config.yaml || true
	unlink ~/.config/k9s/skins/transparent.yaml || true
	unlink ~/.config/nvim || true
	unlink ~/.config/starship.toml || true
	unlink ~/.tmux.conf || true
	unlink ~/.zprofile || true
	unlink ~/.zshrc || true

clean-mac:

	unlink ~/Library/Application\ Support/Code/User/settings.json || true
.PHONY: all clean-linux clean-mac sync-linux sync-mac build run kill
