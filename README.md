# Dotfiles

Personal dotfiles for macOS. Includes ZSH, Neovim, Git, Homebrew packages, and Claude Code, opencode, and Codex configuration.

## Installation

```bash
git clone https://github.com/gciampa/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

## Codex with AWS SSO

Set `BEDROCK_AWS_PROFILE` and `BEDROCK_AWS_REGION` in the untracked
`~/.config/zsh/local.zsh`. The zsh configuration exports those values as
`AWS_PROFILE` and `AWS_REGION`, so Codex uses the native AWS SSO credential
chain:

```bash
codex
```

If the SSO session has expired, run `aws sso login` for the configured profile
before starting Codex.
