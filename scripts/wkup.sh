#!/bin/bash

# Start Tmux
echo "Welcome! Starting your work environment..."
tmux -d
sleep 0.5 && i3-msg 'split h, exec firefox'
sleep 1 && i3-msg '[class="firefox"] resize shrink width 50 px'
sleep 0.5 && i3-msg 'split h, exec obsidian'
sleep 1.5 && i3-msg '[class="obsidian"] resize shrink width 200 px'
sleep 1 && i3-msg '[class="firefox"] focus'
sleep 1 && tmux attach
echo "Have a great rest of the day!"
