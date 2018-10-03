source $HOME/.zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle bundler
antigen bundle osx
antigen bundle heroku
antigen bundle rake
antigen bundle ruby
antigen bundle sudo
antigen bundle themes
antigen bundle zsh-autosuggestions
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme lambda

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


which git > /dev/null && alias g='git'
#alias mergesolv='git status --short | grep "^AA" | cut -d " " -f2 | xargs vim'
alias -g ni='nvim'
alias -s $ext=nvim # What is this?
which htop > /dev/null && alias -g htop='sudo htop'
# Does this even work on OS X?
alias postgres-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias buu='brew upgrade && brew cleanup -s'
alias -g wh="say -v whisper"
alias be='bundle exec'
eval $(thefuck --alias)
which tmux > /dev/null && alias tm='tmux'
alias resrc='source ~/.zshrc'
#alias ls='ls -F --color --group-directories-first'
# What is this even supposed to do?
alias ftyps="ls -F **/*.* | cut -d '.' -f 2- | sed 's/.\+\.//' | sed 's/\*$//' | sed 's/.*\/$//' | sed 's/.*:$//' | grep -v '^$'"
which tree > /dev/null && alias -g t ='tree'
#  alias retray='trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --tint 0x191970 --height 13 &'
alias tmls='tmux list-sessions'
#alias mosh='mosh -p 60001'

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias ip='curl ipinfo.io/ip'

# Emacs
if type "emacs" &> /dev/null; then
    alias -g em='emacs -nw'
    alias -g ec='emacsclient'
fi

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
which rails > /dev/null && alias r='rails'
source /usr/local/share/chruby/chruby.sh
chruby ruby 2.4.3

# OCaml/Reason
if type "opam" &> /dev/null; then
    eval $(opam config env)
    alias save-utop="cat ~/.utop-history >> ~/Projects/OCaml/history.log"
    alias -g utop-exp="utop ; save-utop"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

which bat > /dev/null && alias cat="bat"
