#!/bin/bash
cd ~/.dotfiles
if [[ ! -d ~/.antidote ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
fi

# oh-my-zsh was replaced by antidote; remove the old checkout.
if [[ -d ~/.dotfiles/.oh-my-zsh ]]; then
    echo "Removing old oh-my-zsh checkout"
    rm -rf ~/.dotfiles/.oh-my-zsh
fi

# Files that live in the repo but shouldn't be linked into ~: repo and
# install-script files, plus configs for tools and setups no longer in use.
SKIP=(
    .git .gitignore .claude .osx
    .Xmodmap .Xresources .xinitrc .xmobarrc .xmonad .keynavrc
    .ackrc .buildout .emacs.d .hgrc .mpd .sup .viper .virtualenvs .virtualenvwrapper
)
skipped() {
    for s in "${SKIP[@]}"; do
        [[ $1 == "$s" ]] && return 0
    done
    return 1
}

# Remove links in ~ that point into ~/.dotfiles but are broken or skipped.
# Only symlinks are touched, never real files.
for link in ~/.[!.]*; do
    [[ -h $link ]] || continue
    target=$(readlink "$link")
    [[ $target == "$HOME/.dotfiles/"* ]] || continue
    if [[ ! -e $link ]] || skipped "$(basename "$link")"; then
        echo "Removing old link $link"
        rm "$link"
    fi
done

for f in .*; do
    # No files ending in "." e.g. . or ..
    if [[ "$f" == *. ]] || skipped "$f"; then
        continue
    fi
    if [[ ! -e ~/$f ]]; then
        ln -s ~/.dotfiles/$f ~/$f
    fi
    if [[ ! -h ~/$f ]]; then
        echo "Warning $HOME/$f is not a symlink."
    fi
done
