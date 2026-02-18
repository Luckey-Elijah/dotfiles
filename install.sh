#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO="https://github.com/Luckey-Elijah/dotfiles.git"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensure brew is on PATH for the rest of this script
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed."
fi

# --- Brew formulae ---
FORMULAE=(cocoapods ffmpeg scrcpy yq zoxide)

echo "Installing brew formulae: ${FORMULAE[*]}"
brew install "${FORMULAE[@]}"

# --- VS Code (cask) ---
if ! brew list --cask visual-studio-code &>/dev/null; then
  echo "Installing VS Code..."
  brew install --cask visual-studio-code
else
  echo "VS Code already installed."
fi

# --- Dotfiles repo ---
if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --ff-only
else
  echo "Cloning dotfiles repo..."
  git clone "$REPO" "$DOTFILES_DIR"
fi

# --- Symlinks ---
link() {
  local src="$1"
  local dest="$2"

  # 1. If the exact symlink already exists and points to the right place, skip it.
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "Skipping: $dest already points to $src"
    return
  fi

  # 2. If it's a symlink pointing elsewhere, just remove the link.
  if [ -L "$dest" ]; then
    rm "$dest"
  # 3. If it's a real file/directory, back it up.
  elif [ -e "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
    echo "Backing up $dest -> $BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $src -> $dest"
}

link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zsh_functions" "$HOME/.zsh_functions"

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"