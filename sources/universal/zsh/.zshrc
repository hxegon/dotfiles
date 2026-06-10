ZSHDIR="${0:A:h}/.zsh"

source "$ZSHDIR/env.zsh"

case "$(uname)" in
    Darwin) source "$ZSHDIR/os-macos.zsh" ;;
    Linux)  source "$ZSHDIR/os-linux.zsh" ;;
esac

source "$ZSHDIR/completion.zsh"
source "$ZSHDIR/history.zsh"
source "$ZSHDIR/aliases.zsh"
source "$ZSHDIR/tools.zsh"
source "$ZSHDIR/functions.zsh"

[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets
