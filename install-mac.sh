#!/bin/bash
set -e
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask for the administrator password once, before the Homebrew installer.
# If sudo is already active, the installer leaves it alone instead of
# clearing it on exit.
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! command -v brew > /dev/null; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Homebrew lives in /opt/homebrew on Apple Silicon and /usr/local on Intel.
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x $brew ]]; then
        eval "$($brew shellenv)"
        break
    fi
done

echo "Setting up defaults per .osx"
. $ROOT/.osx

echo "Installing apps via Homebrew and the Mac App Store"

# Keep going if one package fails. brew bundle passes --adopt for casks, so
# apps installed outside Homebrew are taken over instead of failing.
set +e
brew bundle install --file=$ROOT/.Brewfile

# Things these scripts used to install that are no longer wanted.
echo "Removing apps that are no longer used"
for formula in ack gist pipenv; do
    brew list --formula $formula > /dev/null 2>&1 && brew uninstall --formula $formula
done
for cask in bartender iterm2 pycharm private-internet-access; do
    brew list --cask $cask > /dev/null 2>&1 && brew uninstall --cask $cask
done
set -e

# Show anything else installed that isn't in the Brewfile. Nothing is removed;
# run the printed command with --force to uninstall them.
brew bundle cleanup --file=$ROOT/.Brewfile || true
