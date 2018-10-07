source $HOME/.zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle bundler
antigen bundle osx
antigen bundle heroku
antigen bundle rake
antigen bundle ruby
antigen bundle sudo
antigen bundle zsh-autosuggestions
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle djui/alias-tips

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship
#antigen theme lambda

antigen apply

export PATH="$HOME/.cargo/bin:/usr/local/heroku/bin:/Users/cooperlebrun/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/cooperlebrun/.local/bin:/usr/local/opt/llvm/bin"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  # If in remote session
  export EDITOR='nvim'
else
  # if in local session
  export EDITOR='nvim'
fi

which git > /dev/null && alias g='git'
alias -g ni='nvim'
alias -s $ext=nvim # What is this?
which htop > /dev/null && alias -g htop='sudo htop'
# Does this even work on OS X?
alias buu='brew upgrade && brew cleanup -s'
alias be='bundle exec'
eval $(thefuck --alias)
which tmux > /dev/null && alias tm='tmux'
alias resrc='source ~/.zshrc'
alias -g l='gls'
alias -g ls='gls -F --color --group-directories-first'

# Simple shortcuts for common directories
alias proj='cd ~/Projects'
alias dot='cd ~/dotfiles'

# Heroku
if type "heroku" &> /dev/null; then
    alias he='heroku'
    hscale() {
	heroku ps:scale web=$2 --remote $1
    }
fi

# Docker
if type "docker" &> /dev/null; then
    alias d="docker"
    alias dc="docker-compose"
    alias d-clean='docker rm $(docker ps -qa --no-trunc --filter "status=exited") && docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
fi

# Rust
if type "rustc" &> /dev/null; then
    source $HOME/.cargo/env
    eval $(/usr/libexec/path_helper -s)
fi

# Ruby
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.5.1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--reverse --border -m --preview='bat --color=\"always\" {}'"

which bat > /dev/null && alias cat="bat"
export BAT_THEME="zenburn"

# TODO: enable multi/tweak fzf flags for pretty shit etc
config () {
  # what we need to prepend to a relative dotfile path to make it absolute
  local PREFIX="${HOME}/dotfiles/"

  # Get list of config files
  pushd ~/dotfiles &>/dev/null
  local CONFIG_FILES="$(git ls-files)"
  popd &>/dev/null

  $EDITOR $(echo $CONFIG_FILES | fzf --preview="bat --color=always ${PREFIX}{}" | awk -v p=${PREFIX} '{print p $0}')
}

alias c='config'
alias -g pick="\$(fd --hidden -t f -E .git/ | fzf | awk -v pwd=\$(pwd) '{print pwd \"/\" \$0}')"
