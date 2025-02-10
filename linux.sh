#!/bin/sh

# Setup tmux
ln -s $(pwd)/tmux.conf ~/.tmux.conf
sudo apt install fzf

# Setup alacritty terminal
mkdir -p ~/.config/alacritty/
ln -fs $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml

# Reset the existing bashrc by copying Ubuntu's
cat /etc/skel/.bashrc > ~/.bashrc
# Execute sh.sh from bashrc
echo "source $(pwd)/sh.sh" >> ~/.bashrc

# Set up a script to automatically open your dev setup in regolith
sudo ln -s /home/luke/github.com/lkdm/dotfiles/scripts/wkup.sh /usr/local/bin/wkup
echo -e "\ni3-wm.program.1: /usr/local/bin/wkup" >> ~/.config/regolith3/Xresources

# Set up mt cli tool
sudo ln -s /home/luke/github.com/lkdm/dotfiles/scripts/mt.sh /usr/local/bin/mt
