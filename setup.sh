#!/bin/bash

set -e

echo "Starting setup for development environment..."

# Set up XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"

# Ensure the current directory is the root of the workspace
WORKSPACE_DIR=$(pwd)

# Symlink configurations
ln -sf "$WORKSPACE_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$WORKSPACE_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Update package list and install required tools
sudo apt-get update && sudo apt-get install -y \
  build-essential \
  clang \
  gcc \
  gdb \
  cmake \
  git \
  curl \
  wget \
  python3 \
  python3-pip \
  libtool \
  libtool-bin \
  unzip \
  tar \
  pkg-config \
  software-properties-common \
  fzf \
  ripgrep \
  neovim \
  zsh \
  tmux

# Install LazyVim
echo "Setting up LazyVim..."
mkdir -p "$XDG_CONFIG_HOME/nvim"

# Download LazyVim starter template
 git clone https://github.com/LazyVim/starter "$XDG_CONFIG_HOME/nvim"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Install Oh My Zsh for better Zsh experience
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi

# Install tmux plugin manager (TPM) for managing tmux plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Development environment setup complete!"
