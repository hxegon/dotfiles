# source <(antibody init)
# antibody bundle < $HOME/.antibody_plugins

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

export MY_BIN="$HOME/bin"
export MC_MC="$HOME/Project/Code/comcast/mc/bin/mc"
export RUST_BIN="$HOME/.cargo/bin"
export DOOM_BIN="$HOME/.emacs.d/bin"

export LOCAL_BIN="$HOME/.local/bin"

export PATH="$DOOM_BIN:$RUST_BIN:$MC_MC:$MY_BIN:$LOCAL_BIN:$PATH:"

source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

# Turn off terminal bell/beep for ambiguous list completions
unsetopt LIST_BEEP

export EDITOR='hx'
export BROWSER='open'

# Abbreviations
alias g='git'
alias lg='lazygit'
alias tm='tmux'
alias ni='lvim'
alias niconf='nvim ~/.config/nvim/init.vim'
alias -g htop='sudo htop'
alias dot='cd ~/dotfiles'
alias ls='ls -G'
alias ldcr='lein do clean, repl'

alias bjava='brew outdated | grep -i openjdk'
alias buu='brew upgrade && brew cleanup -s' # brew upgrade / clean old packages
alias bdump='brew bundle dump --force --global' # show all installed brew packages
alias resrc='source ~/.zshrc' # doesn't play well with antigen

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden ~'
export FZF_CTRL_T_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS="--ansi --reverse --border -m --preview='bat --color=\"always\" {}'"

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

alias gch="git branch --list | rev | cut -d' ' -f1 | rev | fzy | xargs -n 1 git checkout"
alias gbr="git branch --list | rev | cut -d' ' -f1 | rev | fzy | xargs -n 1 "
alias gls="git status --porcelain | fzy | cut -c4-"

# Configure thefuck
eval $(thefuck --alias)

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

source "$(brew --prefix)/opt/spaceship/spaceship.zsh"
autoload -Uz promptinit; promptinit
# prompt -s spaceship

# Load NVM
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"'

# TESTING: Faster nvm
eval "$(fnm env --use-on-cd)"

# Load z
. /opt/homebrew/etc/profile.d/z.sh

# TODO Figure out how to bind this to somthing like CMD+c
fzydir () {
  rg --files-with-matches scoop | xargs -n 1 dirname | fzy
}

# Ruby
## load chruby
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh

# Containers
# set DOCKER_HOST as a uri for a podman socket
# https://github.com/containers/podman/issues/13069
# export DOCKER_HOST="$(podman system connection ls --format="{{.URI}}" | grep root)"

# That wasn't working, trying this instead

# export DOCKER_HOST="`cat ~/.config/containers/containers.conf | grep -ioE "ssh://core@localhost:[0-9]+"`"

# check this out if it doesn't work
# https://github.com/containers/podman/issues/11397#issuecomment-910726355

## Aliases
alias be='bundle exec'

# Open tmux project switcher with C-f
# requires 'tmux-sessionizer' -> `cargo install tmux-sessionizer`
# Also requires tms paths to be configured, `tms config --paths path1 path2 ...`
bindkey -s ^f "tms\n"
