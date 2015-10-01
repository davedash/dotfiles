#!/bin/bash
set -e
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up defaults per .osx"
. $ROOT/.osx

echo "Installing apps via Homebrew"

set +e
grep -v '^#' $ROOT/.homebrew | xargs brew install
set -e

echo "Installing apps via Homebrew Cask"

grep -v '^#' $ROOT/.homebrew_cask | xargs brew cask install

echo "Installing system python things that I want everywhere"

sudo pip install -U fig
