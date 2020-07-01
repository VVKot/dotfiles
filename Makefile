all: sync

sync:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.vim/coc-settings.json ] || ln -s $(PWD)/vim/coc-settings.json ~/.vim/coc-settings.json
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.inputrc ] || ln -s $(PWD)/inputrc ~/.inputrc

clean:
	rm -f ~/.vimrc 
	rm -f ~/.vim/coc-settings.json
	rm -f ~/.tmux.conf
	rm -f ~/.ideavimrc
	rm -f ~/.inputrc

.PHONY: all clean sync build run kill
