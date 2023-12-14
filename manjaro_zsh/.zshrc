# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

### PATH ###

export MY_BIN="$HOME/scripts"
export DOOM_BIN="$HOME/.config/emacs/bin"
export HYPR_BIN="$HOME/.config/hypr/bin"
export PATH="$MY_BIN:$DOOM_BIN:$HYPR_BIN:$PATH"

### END PATH

export EDITOR=nvim

### BEGIN ALIASES ###

# forgetting sudo with pamac is annoying as hell
alias pamac="sudo pamac"
alias yarn="corepack yarn"
alias npm="corepack npm"
alias g="git"
alias vi="nvim"
alias ni="nvim"
alias lg="lazygit"
alias hx="helix"
alias opamdeps="opam install --deps-only --yes ."
alias opamenv='eval $(opam env)'

alias tm="tmux"
alias tn="tmux new -s" # new tmux session <named>
alias ta="tmux a" # attach to last tmux session
alias ts="tms" # open tmux switcher (~/scripts/tms)

## Convenience functions
copyonchange () { echo $1 | entr -cps "cat $1 | pbcopy" }

## Initializations
# Initialize antidote (zsh package manager)
source '/usr/share/zsh-antidote/antidote.zsh' && antidote load || echo 'failed to load antidote'

# fzy plugin
bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
zstyle :fzy:file command fd -j2 -tf -HIL -c never --ignore-file ~/.fdignore
zstyle :fzy:history command tac $HOME/.zhistory
zstyle :fzy:tmux enabled no

# opam configuration
[[ ! -r /home/hxe/.opam/opam-init/init.zsh ]] || source /home/hxe/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval $(opam env)

# enable asdf
. /opt/asdf-vm/asdf.sh

# starship prompt
eval "$(starship init zsh)"
