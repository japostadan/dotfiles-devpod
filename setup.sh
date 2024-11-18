#!/bin/bash

echo "Starting setup for development environment..."

# Set up XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

# Create symlinks for existing configurations
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf


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
  lazygit \
  fzf \

echo "Finished downloading Packages"

# Set up pure prompt
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
echo "Development environment setup is up"
