autoload -Uz colors && colors
autoload -Uz vcs_info
export EDITOR="vim"
#export TERM="rxvt-unicode-256color"
#export PATH="/usr/local/heroku/bin:$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/bin:$PATH" # Add ~/bin to path
export PATH="$HOME/.rbenv/bin:$PATH" # add rbenv to path.

# rbenv stuff above and below
HISTFILE=~/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob prompt_subst
unsetopt beep nomatch notify

## Case insensitive completion
autoload -Uz compinit
compinit -C

# git branch in prompt. No idea what any of this is
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
	    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':vcs_info:*' actionformats \
      '%F{5}%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
      '%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

## Prompt
# username@hostname:last2parentdirectories #(number of jobs if any or =)> 
PS1="%n @ %3c -- %* 
#%(1j.%j.=)>%{$reset_color%} "
# current git branch
RPROMPT=$'$(vcs_info_wrapper)'

#TODO: migrate aliases to their own file and adjust
## General Aliases
alias todo='grep -i -v "#done" ~/todo'
alias copyin='xclip -i -selection clipboard'
alias resrc='source ~/.zshrc'
if which git > /dev/null; then alias g='git'; fi
if which vagrant > /dev/null; then alias v='vagrant'; fi
if which bundle > /dev/null; then alias be='bundle exec'; fi

# Does this work?
if [[ "$OSTYPE" == "darwin"* ]]; then # THESE SHOULD ALL BE OS X SPECIFIC
  # Because htop doesn't work on osx without sudo
  if which htop > /dev/null; then alias -g htop='sudo htop'; fi
  # because macvim
  if which mvim > /dev/null; then
    alias -g vi='mvim -v'
    alias -g vim='mvim -v'
  fi
  # postgres start
  if which psql > /dev/null; then
    alias postgres-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  fi
fi

## Directory shortcuts
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ls='ls -F'
alias la='ls -a'
alias lc='ls --color'
if which tree > /dev/null; then alias -g t ='tree'; fi

## Awesome aliases
# TODO: figure out what these do and label them better
# Open unsolved merge conflicts in vim as buffers (not 100%)
#alias mergesolv='git status --short | grep "^AA" | cut -d " " -f2 | xargs vim'
alias ftyps="ls -F **/*.* | cut -d '.' -f 2- | sed 's/.\+\.//' | sed 's/\*$//' | sed 's/.*\/$//' | sed 's/.*:$//' | grep -v '^$'"

## mpd/mpc/ncmpcpp aliases
# TODO: check if mpd is installed before setting these aliases
#alias tog='mpc toggle'
#alias playing='mpc current'
#alias gateways='cat ~/.vpnstuff/gateways.txt | grep .com | cut -d. -f1'

## Bindkeys
bindkey '^R' history-incremental-search-backward
#eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#[ ! "$UID" = "0" ] && archbey2
# fix irssi behaviour in screen and tmux
[ -n "$TMUX" ] && export TERM="screen-256color"
