This is my treasure trove.  I `git clone` it to `~/.dotfiles` and then do

    ~/.dotfiles/install.sh

which symlinks the dotfiles into `~`, removes old links that point into this
repo, and installs antidote for zsh plugins.

On a Mac, sign in to the App Store and run

    ~/.dotfiles/install-mac.sh

which installs [Homebrew](https://brew.sh) if needed, applies the macOS
defaults in `.osx`, installs everything in `.homebrew` and
`.homebrew_cask`, uninstalls apps that were dropped from those lists, and
installs App Store apps with `mas`.
