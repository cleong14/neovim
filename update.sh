#!/usr/bin/env bash
# shellcheck disable=2086

set -e

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
git pull origin master
git pull upstream master --rebase
git push origin master --force-with-lease

# 3. Build nvim
echo ""
echo "Building Neovim..."
echo ""
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/nvim
make install

echo ""
echo "Successfully updated & built Neovim!"
echo ""
