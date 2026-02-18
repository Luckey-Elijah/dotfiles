# dotfiles

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/Luckey-Elijah/dotfiles/main/install.sh | bash
```

This will:

1. Clone the repo to `~/.dotfiles` (or pull if it already exists)
2. Back up any existing `.zshrc`, `.zshenv`, and `.zsh_functions` to
   `~/.dotfiles_backup/<timestamp>/`
3. Symlink the repo files into `$HOME`