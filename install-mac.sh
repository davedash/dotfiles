#!/bin/bash
set -e
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

echo "Installing apps via Homebrew"

set +e
grep -v '^#' $ROOT/.homebrew | xargs brew install
set -e

echo "Installing apps via Homebrew Cask"

grep -v '^#' $ROOT/.homebrew_cask | xargs brew install --cask

echo "Installing apps via the Mac App Store"

mas install 1091189122  # Bear
