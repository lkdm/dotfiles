#!/usr/bin/env bash
# Mark all scripts in ~/bin as executable
# Which allows us to avoid prepending each script with executable_
chmod +x ~/bin/*

# Rename any *.sh scripts to remove the .sh extension
for file in ~/bin/*.sh; do
  # Check if matching files exist
  [ -e "$file" ] || continue
  base="${file%.sh}"
  mv "$file" "$base"
done
