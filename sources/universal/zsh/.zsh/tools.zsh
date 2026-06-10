eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

eval "$(git gtr init zsh)"
alias gg="git gtr"

export FZF_DEFAULT_COMMAND='rg --files --hidden ~'
export FZF_CTRL_T_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS="--ansi --reverse --border -m --preview='bat --color=\"always\" {}'"

export BAT_THEME="zenburn"
