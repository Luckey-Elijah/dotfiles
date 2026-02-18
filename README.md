# dotfiles

My macOS zsh environment setup — one command to install everything.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/Luckey-Elijah/dotfiles/main/install.sh | bash
```

Then reload your shell:

```bash
source ~/.zshrc
```

## What gets installed

| Category | Tools                                           |
| -------- | ----------------------------------------------- |
| Shell    | Oh My Zsh, Powerlevel10k                        |
| Brew     | cocoapods, ffmpeg, scrcpy, yq, zoxide           |
| Editor   | VS Code                                         |
| Flutter  | Puro v1.5.0                                     |
| Dotfiles | `.zshrc`, `.zshenv`, `.zsh_functions` symlinked |

## Re-running

The script is idempotent — safe to run again to pull the latest config
changes. Existing files are backed up to `~/.dotfiles_backup/`.