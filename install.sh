#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO="https://github.com/Luckey-Elijah/dotfiles.git"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

# Clone or update repo
if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --ff-only
else
  echo "Cloning dotfiles repo..."
  git clone "$REPO" "$DOTFILES_DIR"
fi

# Backup and symlink a file/directory
link() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up $dest -> $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $src -> $dest"
}

# Symlink zsh files
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zsh_functions" "$HOME/.zsh_functions"

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"