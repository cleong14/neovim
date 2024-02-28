#!/usr/bin/env bash
# shellcheck disable=2086

set -o errexit -o noclobber -o pipefail
shopt -s failglob inherit_errexit

# # uncomment if you want to print a message when the script exits
# trap 'echo "Caught EXIT signal, exiting..."' EXIT
trap 'echo "ERROR: Caught ERR signal, exiting..."' ERR

echo ""
echo "╭───────────────╮"
echo "│ Update Neovim │"
echo "╰───────────────╯"
echo ""

# 1. Clean build
echo "Cleaning previous build..."
echo ""
rm -rf $HOME/.local/nvim
make distclean

# 2. Update source
echo ""
echo "Updating Neovim source..."
echo ""
git pull origin master --rebase --allow-unrelated-histories
git pull upstream master --rebase --allow-unrelated-histories
git push origin master --force-with-lease

# 3. Build nvim
echo ""
echo "Building Neovim..."
echo ""
# make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/nvim
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim"
make install

echo ""
echo "Successfully updated & built Neovim!"
echo ""
