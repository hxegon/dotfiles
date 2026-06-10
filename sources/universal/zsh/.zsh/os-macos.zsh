[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

export BROWSER='open'
alias ls='ls -G'

alias bjava='brew outdated | grep -i openjdk'
alias buu='brew upgrade && brew cleanup -s'
alias bdump='brew bundle dump --force --global'

[ -f /opt/homebrew/etc/profile.d/z.sh ] && . /opt/homebrew/etc/profile.d/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.lmstudio/bin:$PATH"

function copyonchange() {
    echo $1 | entr -cps "cat $1 | pbcopy"
}
