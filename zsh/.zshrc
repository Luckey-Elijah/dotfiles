ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git z)
source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"

# utils
alias cl="clear; lm"
alias code='open -a "Visual Studio Code"'
alias c="code ."
alias drcl="dart run custom_lint"
alias brw="dart run build_runner watch -d"
alias brb="dart run build_runner build -d"
alias brc="dart run build_runner clean"
alias sim="open -a Simulator"

# At the end of .zshrc
fpath=(~/.zsh_functions $fpath)
autoload -Uz _cmd podfix brewup cleanup pub_flutter_version branch lm featup