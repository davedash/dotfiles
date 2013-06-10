#!/bin/bash
cd ~/.dotfiles
for f in * .*; do
    if [ "$f" = ".git" ]; then
	continue
    fi
    # No files ending in "." e.g. . or ..
    if [[ "$f" == *. ]]; then
	continue
    fi
    if [[ "$f" != .* ]]; then
	continue
    fi
    ln -s ~/.dotfiles/$f ~/$f
done
