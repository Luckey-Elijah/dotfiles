#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO="https://github.com/Luckey-Elijah/dotfiles.git"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# --- Brew Formulae & Casks ---
FORMULAE=(cocoapods ffmpeg scrcpy yq zoxide)
echo "Installing brew formulae: ${FORMULAE[*]}"
brew install "${FORMULAE[@]}"

if ! brew list --cask visual-studio-code &>/dev/null; then
  echo "Installing VS Code..."
  brew install --cask visual-studio-code
fi

# --- Puro ---
if ! command -v puro &>/dev/null; then
  echo "Installing Puro v1.5.0..."
  curl -o- https://puro.dev/install.sh | PURO_VERSION="1.5.0" bash
else
  echo "Puro already installed."
fi

# --- Dotfiles Repo ---
if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --ff-only
else
  echo "Cloning dotfiles repo..."
  git clone "$REPO" "$DOTFILES_DIR"
fi

# --- Graceful Symlinking ---
link() {
  local src="$1"
  local dest="$2"

  # Skip if the link already points to the correct source
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi

  # If it's a symlink pointing elsewhere, remove it
  if [ -L "$dest" ]; then
    rm "$dest"
  # If it's a real file/dir, back it up
  elif [ -e "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up $dest -> $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $src -> $dest"
}

link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zsh_functions" "$HOME/.zsh_functions"

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"