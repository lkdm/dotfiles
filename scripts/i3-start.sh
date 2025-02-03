#!/bin/bash

## Opens workspace 1

# Open windows as before
sleep 1 && i3-msg 'workspace 1'
sleep 1.5 && i3-msg 'exec alacritty'
sleep 0.2 && i3-msg 'workspace 1; [class="Alacritty"] focus'
# Execute commands in the focused Alacritty window
sleep 0.5 && i3-msg 'exec --no-startup-id xdotool type "mt start" && xdotool key Return'

sleep 0.5 && i3-msg 'split v, exec alacritty'
sleep 0.5 && i3-msg 'split v, exec alacritty'

# Create a new horizontal split for Firefox and Obsidian
sleep 0.5 && i3-msg 'split h, exec firefox'
sleep 0.5 && i3-msg 'split h, exec obsidian'
sleep 1 && i3-msg '[class="firefox"] move right'
sleep 1 && i3-msg '[class="obsidian"] move right, move right'
sleep 1 && i3-msg '[class="firefox"] focus'
sleep 0.5 && i3-msg 'resize grow width 100 px'


sleep 0.5 && i3-msg 'workspace 2'
sleep 0.5 && i3-msg 'exec alacritty'
sleep 0.5 && i3-msg '[class="Alacritty"] focus'
sleep 0.5 && i3-msg 'exec --no-startup-id xdotool type "nvim ~/trionline" && xdotool key Return'
