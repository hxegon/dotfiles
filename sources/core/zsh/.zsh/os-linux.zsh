export HYPR_BIN="$HOME/.config/hypr/bin"
export PATH="$HOME/scripts:$HYPR_BIN:$PATH"

alias ls='ls --color=auto'

command -v linuxbrew &>/dev/null && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

export ELECTRON_OZONE_PLATFORM_HINT=wayland

[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh >/dev/null 2>/dev/null
