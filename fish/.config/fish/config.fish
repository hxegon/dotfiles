# Use the set -Ua fish_user_paths path/to/add $fish_user_paths to persistently add something to the path

## ENV VARS
set -gx EDITOR nvim

# GO
set -gx GOPATH $HOME/Code/Go
set -gx GOROOT /usr/local/opt/go/libexec

# FZF
set -gx FZF_DEFAULT_COMMAND "fd --hidden -d 8 --type d --type f . $HOME"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --hidden -d 8 -t d . $HOME"

# RUBY
set -gx MY_DEFAULT_RUBY ruby-2.7.2

# abbreviations
alias del='rmtrash'
alias rm='echo Use rmtrash or /bin/rm if you really need to delete something'
alias buu='brew upgrade && brew cleanup -s' # brew upgrade / clean old packages
alias lg="ls | grep -i"
alias llg="ls -lh | grep -i"
alias tm="tmux"
alias e="$EDITOR"
alias ez="$EDITOR (fzf)"
alias g="git"
alias config="$EDITOR $HOME/.config/fish/config.fish"

# "Most Recent Download", gives the past for the most recently added file in ~/Downloads
function mrd
  echo ~/Downloads/(ls -t ~/Downloads | head -n 1)
end

# Chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

## POST CONFIG
chruby $MY_DEFAULT_RUBY
