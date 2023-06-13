#!/bin/bash

echo "Installing oh my zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing rebase-editor"
yarn global add rebase-editor

echo "Updated .zshrc reference"
ln -sf ~/dotfiles/.zshrc ~/.zshrc && . ~/.zshrc
