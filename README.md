gciampa dotfiles
===============

I use [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) and
gciampa/dotfiles together using the `*.local` convention described in
thoughtbot/dotfiles.

Requirements
------------

Set zsh as your login shell.

    chsh -s /bin/zsh

Install
-------

Clone onto your laptop:

    git clone git://github.com/thoughtbot/dotfiles.git
    git clone git://github.com/gciampa/dotfiles.git dotfiles-local

Install [rcm](https://github.com/thoughtbot/rcm).

    brew tap thoughtbot/formulae
    brew install rcm

Install the dotfiles:

    env RCRC=$HOME/dotfiles/rcrc rcup

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

* Exclude the `README.md`, `LICENSE`, and `Brewfile` files, which are part of
  the `dotfiles` repository but do not need to be symlinked in.
* Give precedence to personal overrides which by default are placed in
  `~/dotfiles-local`

You can safely run `rcup` multiple times to update:

    rcup

What's in it?
-------------

[vim](http://www.vim.org/) configuration:

* Customized key mappings

[git](http://git-scm.com/) configuration:

* `l` alias for a pretty git log (from [Gary Bernhardt's dotfiles.](https://github.com/garybernhardt/dotfiles/blob/master/.githelpers))
* `dc` alias for diff --cached.

[zsh](http://zsh.sourceforge.net/FAQ/zshfaq01.html) configuration and aliases:

* [chruby](https://github.com/postmodern/chruby) setup.
* Customized aliases
