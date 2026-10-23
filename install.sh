#!/bin/bash
cd ~/.dotfiles
git submodule update --init
if [[ ! -d ~/.antidote ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
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
