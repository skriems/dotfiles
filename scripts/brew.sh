#! /bin/bash

install_packages() {
  # Install packages using Homebrew
  brew install \
    fish fisher tmux neovim tldr \
    bat fzf httpie httpstat jq keychain lazygit ripgrep trash wget yq webp \
    jenv nvm pyenv rbenv \
    go opam php lua luajit luarocks \
    go-task awscli watch ffmpeg \
    caddy nixpacks ngrok nats-io/nats-tools/nats nats nsc \
    hadolint \
    pearcleaner stats \
    keycastr \
}

# Check if Homebrew is already installed
if command -v brew &>/dev/null; then
  echo "Homebrew is already installed."
  install_packages
else
  # Install Homebrew securely using the provided link
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh
  install_packages
fi

# Optional: Verify if Homebrew installation was successful.
echo "Verify that Homebrew is installed by running 'brew --version'."

if command -v rustup &>/dev/null; then
  echo "rustup already installed"
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
