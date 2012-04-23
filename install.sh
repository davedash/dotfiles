cd ~/.dotfiles
for f in * .*; do
    if [ "$f" = ".git" ]; then
	continue
    fi
    ln -s ~/.dotfiles/$f ~/$f
done
