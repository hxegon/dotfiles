autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

unsetopt LIST_BEEP
