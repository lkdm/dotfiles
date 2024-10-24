#!/bin/sh

alias container="docker exec -it $(docker ps -q --filter expose=5678) zsh"

# Fix Docker compatibility issue with Ubuntu
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 \
	&& echo "Enabled Docker compatibility mode for newer Ubuntu" \
	&& clear


