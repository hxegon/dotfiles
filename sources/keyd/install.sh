#!/usr/bin/env bash

echo "ENSURE THAT KEYD IS INSTALLED FIRST"

which keyd || exit
sudo systemctl enable keyd --now
ln -s "$HOME/dotfiles/sources/keyd/default.conf" /etc/keyd/default.conf
sudo keyd reload
