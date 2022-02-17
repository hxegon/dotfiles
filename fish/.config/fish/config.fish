# Use the set -Ua fish_user_paths path/to/add $fish_user_paths to persistently add something to the path

## ENV VARS
set -gx EDITOR nvim

# GO
set -gx GOPATH $HOME/Code/Go
set -gx GOROOT /usr/local/opt/go/libexec

# FZF
set -gx FZF_DEFAULT_OPTS "-0 --layout=reverse --border --bind '?:toggle-preview' --preview 'bat --style=numbers --color=always {}' --preview-window hidden"
set -gx FZF_DEFAULT_COMMAND "fd --hidden -d 8 ."
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND $HOME"
set -gx FZF_ALT_C_COMMAND "fd --hidden -d 8 -t d . $HOME"

# RUBY
set -gx MY_DEFAULT_RUBY ruby-2.7.2

# NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# emacs vterm integration
function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# abbreviations
alias del='rmtrash'
alias rm='echo Use rmtrash or /bin/rm if you really need to delete something'
alias buu='brew upgrade && brew cleanup -s' # brew upgrade / clean old packages
alias lg="ls | grep -i"
alias llg="ls -lh | grep -i"
alias tm="tmux"
alias e="$EDITOR"
alias ez="$EDITOR (fzf)"
alias eg="$EDITOR (git ls-files | fzf)"
alias g="git"
alias config="$EDITOR $HOME/.config/fish/config.fish"
alias be="bundle exec"
alias d-clean 'docker rm (docker ps -qa --no-trunc --filter "status=exited") && docker rmi (docker images --filter "dangling=true" -q --no-trunc)'
alias gac="git add --all && git commit"

# Chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish
chruby ruby-2.7.2

## POST CONFIG
chruby $MY_DEFAULT_RUBY
