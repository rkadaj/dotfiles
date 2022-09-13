#!/bin/bash

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install mcfly
sh -c "$(curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly)"

# Install ohmyzsh custom plugins
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Packages
sudo apt-get install -y fzf
sudo apt install kitty-terminfo

# Install Yarn Packages
yarn global add rebase-editor

# Update the git config
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# Update the zsh config
ln -sf ~/dotfiles/.zshrc ~/.zshrc && . ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
