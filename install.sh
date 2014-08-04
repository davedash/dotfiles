#!/bin/bash
cd ~/.dotfiles
git submodule update --init
if [[ ! -d .oh-my-zsh ]]; then
    git clone git@github.com:robbyrussell/oh-my-zsh.git .oh-my-zsh
fi
for f in * .*; do
    if [ "$f" = ".git" ]; then
	    continue
    fi
    if [ "$f" = ".gitignore" ]; then
      continue
    fi
    # No files ending in "." e.g. . or ..
    if [[ "$f" == *. ]]; then
      continue
    fi
    if [[ "$f" != .* ]]; then
      continue
    fi
    if [[ ! -e ~/$f ]]; then
      ln -s ~/.dotfiles/$f ~/$f
    fi
    if [[ ! -h ~/$f ]]; then
      echo "Warning $HOME/$f is not a symlink."
    fi

done
