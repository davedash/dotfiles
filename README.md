This is my treasure trove.  I `git clone` it to `~/.dotfiles` and then do

    ~/.dotfiles/install.sh

which symlinks the dotfiles into `~` and installs antidote for zsh plugins.

On a Mac, first install [Homebrew](https://brew.sh), sign in to the App
Store, and run

    ~/.dotfiles/install-mac.sh

which applies the macOS defaults in `.osx`, installs everything in
`.homebrew` and `.homebrew_cask`, and installs App Store apps with `mas`.
