#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO="https://github.com/Luckey-Elijah/dotfiles.git"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
fi

# --- Brew Formulae & Casks ---
FORMULAE=(cocoapods ffmpeg scrcpy yq zoxide)
echo "Installing brew formulae..."
brew install "${FORMULAE[@]}"

# --- VS Code ---
if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "VS Code already installed."
elif brew list --cask visual-studio-code &>/dev/null; then
  echo "VS Code already installed (via brew)."
else
  echo "Installing VS Code..."
  brew install --cask visual-studio-code
fi

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Powerlevel10k ---
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# --- Puro ---
if ! command -v puro &>/dev/null; then
  echo "Installing Puro..."
  curl -o- https://puro.dev/install.sh | PURO_VERSION="1.5.0" bash < /dev/null
fi

# --- Dotfiles Repo ---
if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles..."
  git -C "$DOTFILES_DIR" fetch origin
  git -C "$DOTFILES_DIR" reset --hard origin/main
else
  echo "Cloning dotfiles..."
  git clone "$REPO" "$DOTFILES_DIR"
fi

# --- Graceful Symlinking ---
link() {
  local src="$1"
  local dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
  fi
  # Remove dest if it still exists (e.g. directory edge case)
  rm -rf "$dest"
  ln -s "$src" "$dest"
  echo "Linked $src -> $dest"
}

link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zsh_functions" "$HOME/.zsh_functions"

echo ""
echo "Done! Run the following to apply: source ~/.zshrc"