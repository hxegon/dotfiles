# Path to your oh-my-zsh installation.
export ZSH=/Users/cooperlebrun/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler osx rake ruby)

# User configuration

export PATH="/usr/local/heroku/bin:/Users/cooperlebrun/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/cooperlebrun/.local/bin:/usr/local/opt/llvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
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
which heroku > /dev/null && alias he='heroku'
alias -g ni='nvim'
alias -s $ext=nvim
alias save-utop="cat ~/.utop-history >> ~/Projects/OCaml/history.log"
alias -g utop-exp="utop ; save-utop"
which htop > /dev/null && alias -g htop='sudo htop'
which mvim > /dev/null && alias -g vim='mvim -v'
alias postgres-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias buu='brew update && brew upgrade'
alias -g wh="say -v whisper"
alias be='bundle exec'
which rails > /dev/null && alias r='rails'
eval $(thefuck --alias)
which tmux > /dev/null && alias tm='tmux'
alias resrc='source ~/.zshrc'
#alias ls='ls -F --color --group-directories-first'
alias la='ls -a'
alias lc='ls --color'
alias ftyps="ls -F **/*.* | cut -d '.' -f 2- | sed 's/.\+\.//' | sed 's/\*$//' | sed 's/.*\/$//' | sed 's/.*:$//' | grep -v '^$'"
which tree > /dev/null && alias -g t ='tree'
#  alias retray='trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --tint 0x191970 --height 13 &'
alias -g em='emacs -nw'
alias -g ec='emacsclient'
alias tmls='tmux list-sessions'

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias scripts='ls ~/bin'
alias ip='curl ipinfo.io/ip'

hscale() {
  heroku ps:scale web=$2 --remote $1
}
#alias mosh='mosh -p 60001'

alias d="docker"
alias dc="docker-compose"
alias d-clean='docker rm $(docker ps -qa --no-trunc --filter "status=exited") && docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'

#source $HOME/.cargo/env
eval $(/usr/libexec/path_helper -s)

# CHRUBY
source /usr/local/share/chruby/chruby.sh
chruby ruby 2.4.2

# OCaml/Reason
eval $(opam config env)
