.PHONY: install brew zsh nvim git ghostty claude bin clean

install: brew zsh nvim git ghostty claude bin

brew:
	brew bundle --file=Brewfile

zsh:
	mkdir -p ~/.config/zsh
	ln -sf $(PWD)/zshenv ~/.zshenv
	ln -sf $(PWD)/config/zsh/.zshrc ~/.config/zsh/.zshrc
	ln -sf $(PWD)/config/zsh/.zprofile ~/.config/zsh/.zprofile
	ln -sf $(PWD)/config/zsh/functions ~/.config/zsh/functions
	ln -sf $(PWD)/config/zsh/themes ~/.config/zsh/themes
	ln -sf $(PWD)/config/starship.toml ~/.config/starship.toml

nvim:
	ln -sf $(PWD)/config/nvim ~/.config/nvim

git:
	ln -sf $(PWD)/git/gitconfig ~/.gitconfig
	ln -sf $(PWD)/git/gitignore ~/.gitignore
	ln -sf $(PWD)/git/gitmessage ~/.gitmessage
	ln -sf $(PWD)/git/githelpers ~/.githelpers

ghostty:
	mkdir -p ~/.config/ghostty
	ln -sf $(PWD)/config/ghostty/config ~/.config/ghostty/config

claude:
	mkdir -p ~/.claude
	ln -sf $(PWD)/claude/CLAUDE.md ~/.claude/CLAUDE.md
	ln -sf $(PWD)/claude/statusline.sh ~/.claude/statusline.sh
	@if [ ! -f ~/.claude/settings.json ]; then \
		cp $(PWD)/claude/settings.json ~/.claude/settings.json; \
		echo "Created ~/.claude/settings.json - edit with your values"; \
	fi

bin:
	mkdir -p ~/.bin
	ln -sf $(PWD)/bin/dm ~/.bin/dm

clean:
	rm -f ~/.zshenv
	rm -rf ~/.config/zsh
	rm -f ~/.config/nvim
	rm -f ~/.config/starship.toml
	rm -f ~/.gitconfig ~/.gitignore ~/.gitmessage ~/.githelpers
	rm -f ~/.config/ghostty/config
	rm -f ~/.claude/CLAUDE.md ~/.claude/settings.json ~/.claude/statusline.sh
	rm -f ~/.bin/dm
