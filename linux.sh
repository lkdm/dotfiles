#!/bin/sh

# Setup alacritty terminal
mkdir -p ~/.config/alacritty/
ln -fs $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml

# Reset the existing bashrc by copying Ubuntu's
cat /etc/skel/.bashrc > ~/.bashrc
# Execute sh.sh from bashrc
echo "source $(pwd)/sh.sh" >> ~/.bashrc
