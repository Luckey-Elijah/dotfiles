export ZSH='/Users/eluckey/.oh-my-zsh'

path+=('/usr/local/opt/openjdk/bin')
path+=('/Users/eluckey/Tools/flutter/bin')
path+=('/Users/eluckey/go/bin')
path+=('/Users/eluckey/.pub-cache/bin')
path+=('/usr/local/sbin')

ZSH_THEME='spaceship'

plugins=(git z flutter)

source $ZSH/oh-my-zsh.sh

# Custom aliases!
alias -g python='python3' # I don't ever use python 2
alias pip='pip3'
alias py='python3' # I don't ever use python 2
alias py3='python3' # I don't ever use python 2
alias ve='python3 -m venv ./venv' # set up python venv
alias va='source ./venv/bin/activate' # activate python venv
alias trash='mv --force -t ~/.Trash' # put items in trash can
alias ip='ipconfig getifaddr en0' # gets current local ip address
alias o='open .' # open current directory in Finder
alias path='echo -e ${PATH//:/\\n}' # cleaner outpoput of echo
alias -g now='date +"%T"' # current time (clean output)
alias -g nowdate='date +"%m-%d-%Y"' # current date (clean output)
alias vi='vim' # I use don't vi
alias wget='wget -c' # useful when forgetting about things
alias -g dl='~/Downloads' # use dir to have
alias afk='pmset displaysleepnow' # sleep displays
alias lt='du -sh */ | sort -hr' # look at the directory sizes
alias rm='rm -i' # I am a dangerous man
alias vg='very_good' # very_good is a lot to type sometimes.

# Bottom of .zshrc file
fpath=( ~/.zshfn "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)
