# Set ZDOTDIR to use XDG-style config location
export ZDOTDIR="${HOME}/.config/zsh"

# mise shims for non-interactive shells (e.g. GUI-launched Neovim)
# Interactive shells use `mise activate` from .zshrc instead
if [ -d "$HOME/.local/share/mise/shims" ]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi
