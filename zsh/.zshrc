source <(antibody init)
antibody bundle < $HOME/.antibody_plugins

bindkey -e

# only compinit once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Setup history stuff
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000


# You may need to manually set your language environment
# export LANG=en_US.UTF-8
source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

# Turn off terminal bell/beep for ambiguous list completions
unsetopt LIST_BEEP

export EDITOR='nvim'
export BROWSER='Safari'

# Abbreviations
alias g='git'
alias tm='tmux'
alias vi='nvim'
alias -g htop='sudo htop'
alias dot='cd ~/dotfiles'

alias buu='brew upgrade && brew cleanup -s' # brew upgrade / clean old packages
alias bdump='brew bundle dump --force --global' # show all installed brew packages
alias resrc='source ~/.zshrc' # doesn't play well with antigen

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--reverse --border -m --preview='bat --color=\"always\" {}'"

export BAT_THEME="zenburn"

# # TODO: enable multi/tweak fzf flags for pretty shit etc
# config () {
#   # what we need to prepend to a relative dotfile path to make it absolute
#   local PREFIX="${HOME}/dotfiles/"

#   # Get list of config files
#   pushd ~/dotfiles &>/dev/null
#   local CONFIG_FILES="$(git ls-files)"
#   popd &>/dev/null

#   $EDITOR $(echo $CONFIG_FILES | fzf --preview="bat --color=always ${PREFIX}{}" | awk -v p=${PREFIX} '{print p $0}')
# }

# alias -g pick="\$(fd --hidden -t f -E .git/ | fzf | awk -v pwd=\$(pwd) '{print pwd \"/\" \$0}')"
wttr () { curl http://wttr.in/$1 }

copyonchange () { echo $1 | entr -cps "cat $1 | pbcopy" }

# Helper function requiring ruby and xsv spreadsheet tool
#
# uses xsv to format csv (from stdin) into fields
# separated by tabs, feeds it to a ruby script string (first argument)
# and formats the stdout of that script string output back
# to csv format.
# NOTES:
# The ruby script prints whatever value $_ is at the end of a given line.
# $. is the line number, 1-indexed.
# -l auto #chomps line endings from $_
# rsv () { xsv fmt -t "\t" | ruby -ple $1 | xsv fmt -d "\t" }
# asv () { xsv fmt -t "\t" | awk -F "\t" $1 | xsv fmt -d "\t" }

# alias rec='ls -1t | head'

# Load NVM
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"'

