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
alias t="tmux"


## Program specific env vars
# FZF
export FZF_CTRL_T_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS="--ansi --reverse --border -m --preview='bat --color=\"always\" {}'"
export BAT_THEME="zenburn"

## Convenience functions
copyonchange () { echo $1 | entr -cps "cat $1 | pbcopy" }

## Initializations
# Initialize antidote (zsh package manager)
source '/usr/share/zsh-antidote/antidote.zsh' && antidote load || echo 'failed to load antidote'

# opam configuration
[[ ! -r /home/hxe/.opam/opam-init/init.zsh ]] || source /home/hxe/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# enable asdf
. /opt/asdf-vm/asdf.sh

# starship prompt
eval "$(starship init zsh)"
