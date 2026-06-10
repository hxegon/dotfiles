alias g='git'
alias lg='lazygit'
alias lt='lazytsm'
alias tm='tmux'
alias ni='nvim'
alias oc='opencode'
alias obs='obsidian-cli'
alias j='just'
alias jc='just --choose'
alias hx='helix'
alias m='make'
alias dot='cd ~/dotfiles'
alias '..'='cd ../'
alias la='ls -a'
alias resrc='source ~/.zshrc'
alias gie='grep -iE'

alias ,='aishell -c'
alias ,,='aishell -c --pro'
alias q='aishell -q'
alias qq='aishell -q --pro'

alias gch="git branch --list | rev | cut -d' ' -f1 | rev | fzf | xargs -n 1 git checkout"
alias gbr="git branch --list | rev | cut -d' ' -f1 | rev | fzf | xargs -n 1 "
alias gls="git status --porcelain | fzf | cut -c4-"

alias be='bundle exec'

bindkey -e
