#!/bin/sh

# Setup alacritty terminal
mkdir -p ~/.config/alacritty/
ln -fs $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml

# Reset the existing bashrc by copying Ubuntu's
cat /etc/skel/.bashrc > ~/.bashrc
# Execute sh.sh from bashrc
echo "source $(pwd)/sh.sh" >> ~/.bashrc

# Set up a script to automatically open your dev setup in regolith
echo -e "\nregolith.exec.1: ~/github.com/lkdm/dotfiles/i3.sh" >> ~/.config/regolith/Xresources
