autoload -Uz colors && colors
autoload -Uz vcs_info
export EDITOR="vim"
#export TERM="rxvt-unicode-256color"
#export PATH="/usr/local/heroku/bin:$HOME/.rbenv/bin:$PATH"
# Add ~/bin to path
export PATH="$HOME/bin:$PATH"

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
PS1="%{$fg[green]%}%n@%m:%2c #%(1j.%j.=)>%{$reset_color%} "
# current git branch
RPROMPT=$'$(vcs_info_wrapper)'

#TODO: migrate aliases to their own file and adjust
## General Aliases
alias todo='grep -i -v "#done" ~/todo'
alias copyin='xclip -i -selection clipboard'
alias resrc='source ~/.zshrc'
alias g='git'


## Directory shortcuts
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ls='ls -F'
alias la='ls -a'
alias lc='ls --color'
alias -g t ='tree'

## Awesome aliases
# TODO: figure out what these do and label them better
# Open unsolved merge conflicts in vim as buffers (not 100%)
alias mergesolv='git status --short | grep "^AA" | cut -d " " -f2 | xargs vim'
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
