# dotfiles

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/Luckey-Elijah/dotfiles/main/install.sh | bash
```

This will:

1. Install [Homebrew](https://brew.sh) (if not already installed)
2. Install formulae: `cocoapods`, `ffmpeg`, `scrcpy`, `yq`, `zoxide`
3. Install [VS Code](https://code.visualstudio.com) via Homebrew cask
4. Clone the repo to `~/.dotfiles` (or pull if it already exists)
5. Back up any existing `.zshrc`, `.zshenv`, and `.zsh_functions` to
   `~/.dotfiles_backup/<timestamp>/`
6. Symlink the repo files into `$HOME`